-- CREATE FOUNDER
CREATE OR REPLACE FUNCTION create_founder(
    _cod_founder VARCHAR,
    _name_founder VARCHAR,
    _id_user UUID
) RETURNS jsonb
AS $$
DECLARE
    _id_founder UUID;
BEGIN
    INSERT INTO founders (cod_founder, name_founder, id_user)
    VALUES (_cod_founder, _name_founder, _id_user)
    RETURNING id_founder INTO _id_founder;
    RETURN jsonb_build_object(
        'id_founder', _id_founder,
        'cod_founder', _cod_founder,
        'name_founder', _name_founder,
        'id_user', _id_user
    );
END;
$$ LANGUAGE plpgsql;

-- UPDATE FOUNDER
CREATE OR REPLACE FUNCTION update_founder(
    _id_founder UUID,
    _cod_founder VARCHAR,
    _name_founder VARCHAR,
    _id_user UUID
) RETURNS jsonb
AS $$
BEGIN
    UPDATE founders
    SET cod_founder = _cod_founder,
        name_founder = _name_founder,
        id_user = _id_user
    WHERE id_founder = _id_founder;
    RETURN jsonb_build_object(
        'id_founder', _id_founder,
        'cod_founder', _cod_founder,
        'name_founder', _name_founder,
        'id_user', _id_user
    );
END;
$$ LANGUAGE plpgsql;

-- DELETE FOUNDER
CREATE OR REPLACE FUNCTION delete_founder(
    _id_founder UUID
) RETURNS jsonb
AS $$
BEGIN
    DELETE FROM founders
    WHERE id_founder = _id_founder;
    RETURN jsonb_build_object('id_founder', _id_founder, 'deleted', true);
END;
$$ LANGUAGE plpgsql;
