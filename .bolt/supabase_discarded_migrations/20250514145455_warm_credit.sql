/*
  # Enable HTTP Extension
  
  1. Changes
    - Enables the HTTP extension which is required for making external HTTP requests from Supabase
    - Extension is created in the 'extensions' schema
  
  2. Purpose
    - Allows contact form submissions to successfully send emails via Resend
    - Fixes the 'function extensions.http_post does not exist' error
*/

create extension if not exists http with schema extensions;