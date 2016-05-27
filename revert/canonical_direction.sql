-- Revert canonical_direction:canonical_direction from pg

BEGIN;

drop function newctmlmap.canonical_direction(text);

COMMIT;
