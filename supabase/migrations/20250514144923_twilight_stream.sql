/*
  # Enable net extension for HTTP requests
  
  1. Changes
    - Enable the net extension to allow HTTP requests from database functions
    - Update the handle_new_contact_message function to use http_post correctly
  
  2. Security
    - Function executes with security definer permissions
*/

-- Enable the net extension
CREATE EXTENSION IF NOT EXISTS "http" WITH SCHEMA extensions;

-- Drop existing function if it exists
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

-- Ensure trigger is properly set up
DROP TRIGGER IF EXISTS on_contact_message_created ON contact_messages;
CREATE TRIGGER on_contact_message_created
  AFTER INSERT ON contact_messages
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_contact_message();