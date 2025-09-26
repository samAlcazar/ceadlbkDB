--CREATE SUPER USER
CREATE OR REPLACE FUNCTION create_super_user(
    _super_user character varying,
    _password character varying
) RETURNS jsonb
AS $$
DECLARE
    _id_super_user UUID;
BEGIN
    INSERT INTO super_user (super_user, password)
    VALUES (_super_user, PGP_SYM_ENCRYPT(_password, 'AES_KEY'))
    RETURNING id_super_user INTO _id_super_user;
    RETURN jsonb_build_object('id_super_user', _id_super_user, 'super_user', _super_user);
END;
$$ LANGUAGE plpgsql;

--VALIDATE SUPER USER
CREATE OR REPLACE FUNCTION validate_super_user(
    _super_user character varying,
    _password character varying
) RETURNS jsonb
AS $$
DECLARE
    _id_super_user UUID;
BEGIN
    SELECT id_super_user INTO _id_super_user
    FROM super_user
    WHERE super_user = _super_user
    AND password = PGP_SYM_ENCRYPT(_password, 'AES_KEY');
    IF _id_super_user IS NULL THEN
        RETURN jsonb_build_object('id_super_user', null, 'super_user', _super_user, 'valid', false);
    ELSE
        RETURN jsonb_build_object('id_super_user', _id_super_user, 'super_user', _super_user, 'valid', true);
    END IF;
END;
$$ LANGUAGE plpgsql;
