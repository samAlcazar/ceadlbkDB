--CREATE FOUNDER
CREATE OR REPLACE FUNCTION create_founder(
    _id_founder UUID,
    _name_founder character varying,
    _nick_founder character varying,
    _password_founder character varying,
    _charge_founder character varying,
    _signature_founder character varying,
    _id_profile UUID
) RETURNS jsonb
AS $$
DECLARE
    _id_founder UUID;
BEGIN
    INSERT INTO founder (id_founder, name_founder, nick_founder, password_founder, charge_founder, signature_founder, id_profile)
    VALUES (_id_founder, _name_founder, _nick_founder, PGP_SYM_ENCRYPT(_password_founder, 'AES_KEY'), _charge_founder, _signature_founder, _id_profile)
    RETURNING id_founder INTO _id_founder;
    RETURN jsonb_build_object('id_founder', _id_founder, 'name_founder', _name_founder, 'nick_founder', _nick_founder, 'charge_founder', _charge_founder, 'signature_founder', _signature_founder, 'id_profile', _id_profile);
END;
$$ LANGUAGE plpgsql;

--UPDATE FOUNDER
CREATE OR REPLACE FUNCTION update_founder(
    _id_founder UUID,
    _name_founder character varying,
    _nick_founder character varying,
    _password_founder character varying,
    _charge_founder character varying,
    _signature_founder character varying,
    _id_profile UUID
) RETURNS jsonb
AS $$
DECLARE
    _id_founder UUID;
BEGIN
    UPDATE founder
    SET name_founder = _name_founder,
        nick_founder = _nick_founder,
        password_founder = PGP_SYM_ENCRYPT(_password_founder, 'AES_KEY'),
        charge_founder = _charge_founder,
        signature_founder = _signature_founder,
        id_profile = _id_profile
    WHERE id_founder = _id_founder;
    RETURN jsonb_build_object('id_founder', _id_founder, 'name_founder', _name_founder, 'nick_founder', _nick_founder, 'charge_founder', _charge_founder, 'signature_founder', _signature_founder, 'id_profile', _id_profile);
END;
$$ LANGUAGE plpgsql;

--DELETE FOUNDER
CREATE OR REPLACE FUNCTION delete_founder(
    _id_founder UUID
) RETURNS jsonb
AS $$
DECLARE
    _id_founder UUID;
BEGIN
    DELETE FROM founder
    WHERE id_founder = _id_founder;
    RETURN jsonb_build_object('id_founder', _id_founder, 'deleted', true);
END;
$$ LANGUAGE plpgsql;
