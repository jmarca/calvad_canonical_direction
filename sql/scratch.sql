--- cut from '~/repos/jem/osm/sql/views/routes.sql'


DROP FUNCTION IF EXISTS osm_upgrade.canonical_direction( dir TEXT );
CREATE OR REPLACE FUNCTION osm_upgrade.canonical_direction( dir TEXT ) RETURNS TEXT  AS
$$
DECLARE
   cdirs  TEXT;
BEGIN
   --- Convert the direction arg into a standard set we'll match
   --- against (should really make this a separate function
   IF ( lower(dir) IN ( 'n', 'north', 'northbound' ) ) THEN
             cdirs = 'north';
        ELSIF lower(dir) IN ( 's', 'south', 'southbound' ) THEN
             cdirs = 'south';
        ELSIF lower(dir) IN ( 'e', 'east', 'eastbound' ) THEN
             cdirs = 'east';
        ELSIF lower(dir) IN ( 'w', 'west', 'westbound' ) THEN
             cdirs =  'west';
        ELSE
             RAISE NOTICE '% is an invalid direction', dir;
   END IF;

   RETURN cdirs;
END;
$$ LANGUAGE plpgsql;
