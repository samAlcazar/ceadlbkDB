CREATE OR REPLACE FUNCTION create_user(
    _id_user UUID,
    _name_user character varying,
    _nick_user character varying,
    _password_user character varying,
    _charge_user character varying,
    _signature_user character varying,
    _id_profile UUID,
    _id_super_user UUID,
    _id_proyect UUID
) RETURNS jsonb
AS $$
DECLARE
    _id_user UUID;
BEGIN
    INSERT INTO users (id_user, name_user, nick_user, password_user, charge_user, signature_user, id_profile, id_super_user, id_proyect)
    VALUES (_id_user, _name_user, _nick_user, PGP_SYM_ENCRYPT(_password_user, 'AES_KEY'), _charge_user, _signature_user, _id_profile, _id_super_user, _id_proyect)
    RETURNING id_user INTO _id_user;
    RETURN jsonb_build_object('id_user', _id_user, 'name_user', _name_user, 'nick_user', _nick_user, 'charge_user', _charge_user, 'signature_user', _signature_user, 'id_profile', _id_profile, 'id_super_user', _id_super_user, 'id_proyect', _id_proyect);
END;
$$ LANGUAGE plpgsql;

--VALIDATE USER
CREATE OR REPLACE FUNCTION validate_user(
    _nick_user character varying,
    _password_user character varying
) RETURNS jsonb
AS $$
DECLARE
    _id_user UUID;
BEGIN
    SELECT id_user INTO _id_user
    FROM users
    WHERE nick_user = _nick_user
    AND password_user = PGP_SYM_ENCRYPT(_password_user, 'AES_KEY');
    IF _id_user IS NULL THEN
        RETURN jsonb_build_object('id_user', null, 'nick_user', _nick_user, 'valid', false);
    ELSE
        RETURN jsonb_build_object('id_user', _id_user, 'nick_user', _nick_user, 'valid', true);
    END IF;
END;
$$ LANGUAGE plpgsql;
