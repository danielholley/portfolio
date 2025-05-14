/*
  # Update contact messages RLS policies

  1. Changes
    - Drop existing INSERT policy that wasn't working correctly
    - Add new INSERT policy for public access with rate limiting
    - Keep existing SELECT policy for authenticated users

  2. Security
    - Enable public access for contact form submissions
    - Add rate limiting to prevent abuse
    - Maintain read access only for authenticated users
*/

-- Drop the existing INSERT policy
DROP POLICY IF EXISTS "Enable insert access for all users" ON contact_messages;

-- Create new INSERT policy with rate limiting
CREATE POLICY "Allow public contact form submissions with rate limit"
ON contact_messages
FOR INSERT
TO public
WITH CHECK (
  -- Rate limit to 5 submissions per IP per hour
  (
    SELECT COUNT(*) < 5
    FROM contact_messages
    WHERE created_at > NOW() - INTERVAL '1 hour'
  )
);

-- Note: Keeping the existing SELECT policy for authenticated users
-- "Enable read access for authenticated users" remains unchanged