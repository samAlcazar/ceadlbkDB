--CREATE SUPER USER
CREATE OR REPLACE FUNCTION create_super_user(
    _super_user VARCHAR,
    _password VARCHAR
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
    _super_user VARCHAR,
    _password VARCHAR
) RETURNS jsonb
AS $$
DECLARE
    _user_data RECORD;
BEGIN
    SELECT id_super_user, super_user
    INTO _user_data
    FROM super_user
    WHERE super_user = _super_user
      AND PGP_SYM_DECRYPT(password::bytea, 'AES_KEY') = _password;

    IF _user_data IS NOT NULL THEN
        RETURN jsonb_build_object(
            'id_super_user', _user_data.id_super_user,
            'super_user', _user_data.super_user,
            'validated', true
        );
    ELSE
        RETURN jsonb_build_object('validated', false);
    END IF;
END;
$$ LANGUAGE plpgsql;
