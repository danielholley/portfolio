/*
  # Fix contact form RLS policy

  1. Changes
    - Drop and recreate the INSERT policy for contact_messages table to fix the RLS violation
    - Keep the rate limiting of 5 messages per hour
    - Keep the existing SELECT policy for authenticated users

  2. Security
    - Maintains rate limiting protection
    - Ensures public users can only insert, not read messages
    - Authenticated users can still read all messages
*/

-- Drop the existing INSERT policy
DROP POLICY IF EXISTS "Allow public contact form submissions with rate limit" ON contact_messages;

-- Create new INSERT policy with fixed implementation
CREATE POLICY "Allow public contact form submissions with rate limit"
ON contact_messages
FOR INSERT
TO public
WITH CHECK (
  (
    SELECT count(*) < 5
    FROM contact_messages
    WHERE created_at > now() - interval '1 hour'
  )
);