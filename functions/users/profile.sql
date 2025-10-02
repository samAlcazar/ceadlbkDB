-- CREATE PROFILE
CREATE OR REPLACE FUNCTION create_profile(
    _name_profile VARCHAR,
    _id_super_user UUID
) RETURNS jsonb
AS $$
BEGIN
    INSERT INTO profiles (name_profile, id_super_user)
    VALUES (_name_profile, _id_super_user);
    RETURN jsonb_build_object('name_profile', _name_profile, 'id_super_user', _id_super_user);
END;
$$ LANGUAGE plpgsql;

-- UPDATE PROFILE
CREATE OR REPLACE FUNCTION update_profile(
    _id_profile UUID,
    _name_profile VARCHAR
) RETURNS jsonb
AS $$
BEGIN
    UPDATE profiles
    SET name_profile = _name_profile
    WHERE id_profile = _id_profile;
    RETURN jsonb_build_object('id_profile', _id_profile, 'profile', _name_profile);
END;
$$ LANGUAGE plpgsql;

-- DELETE PROFILE
CREATE OR REPLACE FUNCTION delete_profile(
    _id_profile UUID
) RETURNS jsonb
AS $$
BEGIN
    DELETE FROM profiles
    WHERE id_profile = _id_profile;
    RETURN jsonb_build_object('id_profile', _id_profile, 'deleted', true);
END;
$$ LANGUAGE plpgsql;
