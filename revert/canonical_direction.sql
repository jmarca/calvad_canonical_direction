-- Revert canonical_direction:canonical_direction from pg

BEGIN;

drop function newtbmap.canonical_direction(text);

COMMIT;
