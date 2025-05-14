/*
  # Clean up contact messages table and policies
  
  1. Changes
    - Drop existing trigger and function
    - Ensure correct policies are in place
    
  2. Security
    - Maintain RLS policies for insert and select
*/

-- Drop existing trigger and function
DROP TRIGGER IF EXISTS on_contact_message_created ON contact_messages;
DROP FUNCTION IF EXISTS handle_new_contact_message();

-- Ensure RLS is enabled
ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;

-- Recreate policies
DROP POLICY IF EXISTS "Enable insert for everyone" ON contact_messages;
DROP POLICY IF EXISTS "Enable select for authenticated users" ON contact_messages;

CREATE POLICY "Enable insert for everyone"
ON contact_messages
FOR INSERT
TO public
WITH CHECK (true);

CREATE POLICY "Enable select for authenticated users"
ON contact_messages
FOR SELECT
TO authenticated
USING (true);