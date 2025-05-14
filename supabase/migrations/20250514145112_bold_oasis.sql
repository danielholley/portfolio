/*
  # Enable HTTP Extension
  
  1. Changes
    - Enables the HTTP extension which is required for making HTTP requests from database functions
    - This extension is needed for the contact form functionality to work properly
  
  2. Security
    - The HTTP extension is safe to enable and is commonly used for integrating external services
    - It's required for the contact form email notifications
*/

create extension if not exists http with schema extensions;