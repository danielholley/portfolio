/*
  # Add database trigger for contact form emails
  
  1. Changes
    - Add function to handle new contact messages
    - Create trigger to call function on insert
  
  2. Security
    - Function executes with security definer permissions
*/

-- Create the function that will be called by the trigger
CREATE OR REPLACE FUNCTION handle_new_contact_message()
RETURNS TRIGGER AS $$
BEGIN
  -- Call edge function to send email
  PERFORM
    net.http_post(
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

-- Create the trigger
DROP TRIGGER IF EXISTS on_contact_message_created ON contact_messages;
CREATE TRIGGER on_contact_message_created
  AFTER INSERT ON contact_messages
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_contact_message();