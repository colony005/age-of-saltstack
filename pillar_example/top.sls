base:
  '.*-dev$':
    - match: pcre
    - development

  '.*(?<!-dev)$':
    - match: pcre
    - production

  'hanging(-dev)?':
    - match: pcre
    - wonders.hanging
