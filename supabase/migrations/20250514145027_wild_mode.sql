/*
  # Enable HTTP Extension
  
  1. Changes
    - Enables the HTTP extension required for making HTTP requests from Supabase functions
    
  2. Purpose
    - Allows the contact form to send emails via HTTP requests
    - Required for the contact_messages functionality to work properly
*/

create extension if not exists http with schema extensions;

-- Ensure the extension is available to the authenticated role
grant usage on schema extensions to authenticated;
grant execute on all functions in schema extensions to authenticated;