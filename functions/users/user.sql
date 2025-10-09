--CREATE USER
CREATE OR REPLACE FUNCTION create_user(
    _name_user VARCHAR,
    _nick_user VARCHAR,
    _password_user VARCHAR,
    _charge_user VARCHAR,
    _signature_user VARCHAR,
    _id_profile UUID,
    _id_super_user UUID,
    _id_project UUID
) RETURNS jsonb
AS $$
DECLARE
    _id_user UUID;
BEGIN
    INSERT INTO users (
        name_user, 
        nick_user, 
        password_user, 
        charge_user, 
        signature_user, 
        id_profile, 
        id_super_user, 
        id_project
    )
    VALUES (
        _name_user, 
        _nick_user, 
        PGP_SYM_ENCRYPT(_password_user, 'AES_KEY'),
        _charge_user, 
        _signature_user, 
        _id_profile, 
        _id_super_user, 
        _id_project
    )
    RETURNING id_user INTO _id_user;
    
    RETURN jsonb_build_object(
        'id_user', _id_user, 
        'name_user', _name_user, 
        'nick_user', _nick_user,
        'charge_user', _charge_user,
        'signature_user', _signature_user,
        'id_profile', _id_profile,
        'id_super_user', _id_super_user,
        'id_project', _id_project
    );
END;
$$ LANGUAGE plpgsql;

--UPDATE USER
CREATE OR REPLACE FUNCTION update_user(
    _id_user UUID,
    _name_user VARCHAR,
    _nick_user VARCHAR,
    _password_user VARCHAR,
    _charge_user VARCHAR,
    _signature_user VARCHAR,
    _id_profile UUID,
    _id_super_user UUID,
    _id_project UUID
) RETURNS jsonb
AS $$
BEGIN
    UPDATE users
    SET name_user = _name_user,
        nick_user = _nick_user,
        password_user = PGP_SYM_ENCRYPT(_password_user, 'AES_KEY'),
        charge_user = _charge_user,
        signature_user = _signature_user,
        id_profile = _id_profile,
        id_super_user = _id_super_user,
        id_project = _id_project
    WHERE id_user = _id_user;
    
    RETURN jsonb_build_object(
        'id_user', _id_user, 
        'name_user', _name_user, 
        'nick_user', _nick_user,
        'charge_user', _charge_user,
        'signature_user', _signature_user,
        'id_profile', _id_profile,
        'id_super_user', _id_super_user,
        'id_project', _id_project
    );
END;
$$ LANGUAGE plpgsql;

--DELETE USER
CREATE OR REPLACE FUNCTION delete_user(
    _id_user UUID
) RETURNS jsonb
AS $$
BEGIN
    DELETE FROM users
    WHERE id_user = _id_user;
    
    RETURN jsonb_build_object('id_user', _id_user, 'deleted', true);
END;
$$ LANGUAGE plpgsql;

-- VALIDATE USER
DROP FUNCTION IF EXISTS validate_user(VARCHAR, VARCHAR);
CREATE OR REPLACE FUNCTION validate_user(
    _nick_user VARCHAR,
    _password_user VARCHAR
) RETURNS jsonb
AS $$
DECLARE
    _user_data RECORD;
BEGIN
    SELECT id_user, name_user, nick_user, charge_user, signature_user, id_profile, id_super_user, id_project 
    INTO _user_data
    FROM users 
    WHERE nick_user = _nick_user 
      AND PGP_SYM_DECRYPT(password_user::bytea, 'AES_KEY') = _password_user;

    IF _user_data.id_user IS NOT NULL THEN
        RETURN jsonb_build_object(
            'id_user', _user_data.id_user,
            'name_user', _user_data.name_user,
            'nick_user', _user_data.nick_user,
            'charge_user', _user_data.charge_user,
            'signature_user', _user_data.signature_user,
            'id_profile', _user_data.id_profile,
            'id_super_user', _user_data.id_super_user,
            'id_project', _user_data.id_project,
            'validated', true
        );
    ELSE
        RETURN jsonb_build_object('validated', false);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN jsonb_build_object('validated', false, 'error', SQLERRM);
END;
$$ LANGUAGE plpgsql;
