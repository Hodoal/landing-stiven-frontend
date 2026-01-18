#!/bin/bash

# 1. Fix utils/api.js - Change VITE_API_URL to VITE_API_BASE_URL
sed -i "s/VITE_API_URL/VITE_API_BASE_URL/g" src/utils/api.js

# 2. Fix all hardcoded /api/ routes
find src -name "*.jsx" -o -name "*.js" | while read file; do
  # Replace axios.get('/api/ with proper API_BASE_URL usage
  sed -i "s|await axios.get('/api/\([^']*\)'|await axios.get(\`\${import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api'}/\1\`)|g" "$file"
  sed -i "s|await axios.post('/api/\([^']*\)'|await axios.post(\`\${import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api'}/\1\`)|g" "$file"
  sed -i "s|axios.get('/api/\([^']*\)'|axios.get(\`\${import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api'}/\1\`)|g" "$file"
  sed -i "s|axios.post('/api/\([^']*\)'|axios.post(\`\${import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api'}/\1\`)|g" "$file"
done

echo "✅ Done! API URLs fixed."
