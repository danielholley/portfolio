/*
  # Fix RLS policies for contact messages table

  1. Changes
    - Drop existing RLS policies
    - Create new policies with correct permissions
    - Enable public insert access
    - Restrict read access to authenticated users

  2. Security
    - Anyone can insert new messages
    - Only authenticated users can read messages
*/

-- Drop existing policies
DROP POLICY IF EXISTS "Anyone can insert messages" ON contact_messages;
DROP POLICY IF EXISTS "Authenticated users can read messages" ON contact_messages;

-- Create new policies with correct permissions
CREATE POLICY "Enable insert access for all users" 
ON contact_messages FOR INSERT 
TO public 
WITH CHECK (true);

CREATE POLICY "Enable read access for authenticated users" 
ON contact_messages FOR SELECT 
TO authenticated 
USING (true);

-- Ensure RLS is enabled
ALTER TABLE contact_messages FORCE ROW LEVEL SECURITY;