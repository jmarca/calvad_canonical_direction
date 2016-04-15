SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test canonical_direction!');

select can('newtbmap',ARRAY['canonical_direction']);
-- don't do this test because what if there are other functions in the schema
-- select functions_are('newtbmap',ARRAY['canonical_direction']);
select function_lang_is('newtbmap','canonical_direction',ARRAY['text'],'plpgsql');
select function_returns('newtbmap','canonical_direction',ARRAY['text'],'text');

select is(
    (select newtbmap.canonical_direction('n')),
    'north'
);
select is(
    (select newtbmap.canonical_direction('N')),
    'north'
);
select is(
    (select newtbmap.canonical_direction('North')),
    'north'
);
select is(
    (select newtbmap.canonical_direction('NORTH')),
    'north'
);
-- one way to escape quotes in test:
select throws_ok(
    E'select newtbmap.canonical_direction(\'both\')',
    'P0001',
    'both is an invalid direction',
    'will fail on both'
);

-- otherwise use a prepare

prepare failtest as select newtbmap.canonical_direction('nor');
select throws_ok(
    'failtest',
    'P0001',
    'nor is an invalid direction'
);


SELECT finish();
ROLLBACK;
