-- CREATE
CREATE OR REPLACE FUNCTION create_participant(
    p_name_participant varchar,
    p_gender varchar,
    p_age smallint,
    p_organization varchar,
    p_phone varchar,
    p_type_participant varchar,
    p_municipality varchar,
    p_type_organization varchar,
    p_id_project uuid,
    p_id_founder uuid,
    p_id_activity uuid,
    p_id_user uuid
) RETURNS jsonb AS $$
DECLARE
    v_id_participant uuid;
BEGIN
    INSERT INTO data_base_participants (
        name_participant,
        gender,
        age,
        organization,
        phone,
        type_participant,
        municipality,
        type_organization,
        id_project,
        id_founder,
        id_activity,
        id_user
    ) VALUES (
        p_name_participant,
        p_gender,
        p_age,
        p_organization,
        p_phone,
        p_type_participant,
        p_municipality,
        p_type_organization,
        p_id_project,
        p_id_founder,
        p_id_activity,
        p_id_user
    )
    RETURNING id_participant INTO v_id_participant;

    RETURN jsonb_build_object(
        'id_participant', v_id_participant,
        'name_participant', p_name_participant,
        'gender', p_gender,
        'age', p_age,
        'organization', p_organization,
        'phone', p_phone,
        'type_participant', p_type_participant,
        'municipality', p_municipality,
        'type_organization', p_type_organization,
        'id_project', p_id_project,
        'id_founder', p_id_founder,
        'id_activity', p_id_activity,
        'id_user', p_id_user
    );
END;
$$ LANGUAGE plpgsql;

-- READ
CREATE OR REPLACE FUNCTION read_participant(
    p_id_participant uuid
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(p.*)::jsonb INTO v_result
    FROM data_base_participants p
    WHERE id_participant = p_id_participant;

    RETURN COALESCE(v_result, jsonb_build_object('message', 'Participante no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_participant(
    p_id_participant uuid,
    p_name_participant varchar,
    p_gender varchar,
    p_age smallint,
    p_organization varchar,
    p_phone varchar,
    p_type_participant varchar,
    p_municipality varchar,
    p_type_organization varchar,
    p_id_project uuid,
    p_id_founder uuid,
    p_id_activity uuid,
    p_id_user uuid
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE data_base_participants
    SET name_participant = p_name_participant,
        gender = p_gender,
        age = p_age,
        organization = p_organization,
        phone = p_phone,
        type_participant = p_type_participant,
        municipality = p_municipality,
        type_organization = p_type_organization,
        id_project = p_id_project,
        id_founder = p_id_founder,
        id_activity = p_id_activity,
        id_user = p_id_user
    WHERE id_participant = p_id_participant
    RETURNING row_to_json(data_base_participants.*)::jsonb INTO v_result;

    RETURN COALESCE(v_result, jsonb_build_object('message', 'Participante no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_participant(
    p_id_participant uuid
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM data_base_participants
    WHERE id_participant = p_id_participant
    RETURNING row_to_json(data_base_participants.*)::jsonb INTO v_result;

    RETURN COALESCE(v_result, jsonb_build_object('message', 'Participante no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- LIST ALL
CREATE OR REPLACE FUNCTION list_participants() RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(p.*))
    INTO v_result
    FROM data_base_participants p;

    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- LIST BY PROJECT
CREATE OR REPLACE FUNCTION list_participants_by_project(
    p_id_project uuid
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(p.*))
    INTO v_result
    FROM data_base_participants p
    WHERE id_project = p_id_project;

    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- LIST BY FOUNDER
CREATE OR REPLACE FUNCTION list_participants_by_founder(
    p_id_founder uuid
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(p.*))
    INTO v_result
    FROM data_base_participants p
    WHERE id_founder = p_id_founder;

    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- LIST BY ACTIVITY
CREATE OR REPLACE FUNCTION list_participants_by_activity(
    p_id_activity uuid
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(p.*))
    INTO v_result
    FROM data_base_participants p
    WHERE id_activity = p_id_activity;

    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- LIST BY USER
CREATE OR REPLACE FUNCTION list_participants_by_user(
    p_id_user uuid
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(p.*))
    INTO v_result
    FROM data_base_participants p
    WHERE id_user = p_id_user;

    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;