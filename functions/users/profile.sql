--CREATE PROFILE
CREATE OR REPLACE FUNCTION create_profile(
    _id_profile UUID,
    _name_profile character varying,
    _description_profile character varying
) RETURNS jsonb
AS $$
DECLARE
    _id_profile UUID;
BEGIN
    INSERT INTO profile (id_profile, name_profile, description_profile)
    VALUES (_id_profile, _name_profile, _description_profile)
    RETURNING id_profile INTO _id_profile;
    RETURN jsonb_build_object('id_profile', _id_profile, 'name_profile', _name_profile, 'description_profile', _description_profile);
END;
$$ LANGUAGE plpgsql;

--UPDATE PROFILE
CREATE OR REPLACE FUNCTION update_profile(
    _id_profile UUID,
    _name_profile character varying,
    _description_profile character varying
) RETURNS jsonb
AS $$
DECLARE
    _id_profile UUID;
BEGIN
    UPDATE profile
    SET name_profile = _name_profile,
        description_profile = _description_profile
    WHERE id_profile = _id_profile;
    RETURN jsonb_build_object('id_profile', _id_profile, 'name_profile', _name_profile, 'description_profile', _description_profile);
END;
$$ LANGUAGE plpgsql;

--DELETE PROFILE
CREATE OR REPLACE FUNCTION delete_profile(
    _id_profile UUID
) RETURNS jsonb
AS $$
DECLARE
    _id_profile UUID;
BEGIN
    DELETE FROM profile
    WHERE id_profile = _id_profile;
    RETURN jsonb_build_object('id_profile', _id_profile, 'deleted', true);
END;
$$ LANGUAGE plpgsql;
