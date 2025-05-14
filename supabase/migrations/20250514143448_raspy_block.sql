/*
  # Fix contact messages RLS policy

  1. Changes
    - Drop all existing policies
    - Create new INSERT policy without rate limiting
    - Maintain SELECT policy for authenticated users
    - Re-enable RLS

  2. Security
    - Allow public access for contact form submissions
    - Maintain read access for authenticated users only
*/

-- Drop all existing policies
DROP POLICY IF EXISTS "Allow public contact form submissions with rate limit" ON contact_messages;
DROP POLICY IF EXISTS "Enable read access for authenticated users" ON contact_messages;

-- Create new INSERT policy without rate limiting
CREATE POLICY "Enable public contact form submissions"
ON contact_messages
FOR INSERT
TO public
WITH CHECK (true);

-- Recreate SELECT policy for authenticated users
CREATE POLICY "Enable read access for authenticated users"
ON contact_messages
FOR SELECT
TO authenticated
USING (true);

-- Ensure RLS is enabled
ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;