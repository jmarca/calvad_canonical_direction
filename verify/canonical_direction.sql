-- Verify canonical_direction:canonical_direction on pg

BEGIN;

SELECT pg_catalog.has_function_privilege('newctmlmap.canonical_direction(text)','execute');

ROLLBACK;
