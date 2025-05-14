/*
  # Fix contact messages RLS policies

  1. Changes
    - Drop existing policies to start fresh
    - Create simplified INSERT policy for public access
    - Maintain SELECT policy for authenticated users
    - Re-enable RLS

  2. Security
    - Allow anyone to submit contact messages
    - Only authenticated users can read messages
*/

-- First, drop existing policies to start fresh
DROP POLICY IF EXISTS "Enable public contact form submissions" ON contact_messages;
DROP POLICY IF EXISTS "Enable read access for authenticated users" ON contact_messages;

-- Disable and re-enable RLS to ensure clean state
ALTER TABLE contact_messages DISABLE ROW LEVEL SECURITY;
ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;

-- Create a simple INSERT policy for public access
CREATE POLICY "Enable insert for everyone"
ON contact_messages
FOR INSERT
TO public
WITH CHECK (true);

-- Create SELECT policy for authenticated users
CREATE POLICY "Enable select for authenticated users"
ON contact_messages
FOR SELECT
TO authenticated
USING (true);