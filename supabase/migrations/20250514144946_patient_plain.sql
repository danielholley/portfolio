/*
  # Enable HTTP extension and update contact message trigger
  
  1. Changes
    - Enable HTTP extension in extensions schema
    - Update trigger to use extensions.http_post
    - Fix dependency order when recreating objects
  
  2. Security
    - Function executes with security definer permissions
*/

-- Enable the http extension
CREATE EXTENSION IF NOT EXISTS "http" WITH SCHEMA extensions;

-- Drop existing trigger first
DROP TRIGGER IF EXISTS on_contact_message_created ON contact_messages;

-- Now we can safely drop and recreate the function
DROP FUNCTION IF EXISTS handle_new_contact_message();

-- Recreate the function with correct schema reference
CREATE OR REPLACE FUNCTION handle_new_contact_message()
RETURNS TRIGGER AS $$
BEGIN
  -- Call edge function to send email using the http extension
  PERFORM
    extensions.http_post(
      url := CONCAT(current_setting('app.settings.supabase_url'), '/functions/v1/send-contact-email'),
      headers := jsonb_build_object(
        'Authorization', CONCAT('Bearer ', current_setting('app.settings.service_role_key')),
        'Content-Type', 'application/json'
      ),
      body := jsonb_build_object('record', row_to_json(NEW))
    );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate the trigger
CREATE TRIGGER on_contact_message_created
  AFTER INSERT ON contact_messages
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_contact_message();