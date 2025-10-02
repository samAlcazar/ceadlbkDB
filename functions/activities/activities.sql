-- Create activity
CREATE OR REPLACE FUNCTION create_activity(
    p_activity varchar,
    p_date_start date,
    p_date_end date,
    p_place varchar,
    p_participants_expected smallint,
    p_objetive text,
    p_result_expected text,
    p_description_activity text,
    p_id_project UUID,
    p_id_especific UUID,
    p_id_user UUID,
    p_id_project_result UUID,
    p_id_project_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO activities (
        activity,
        date_start,
        date_end,
        place,
        participants_expected,
        objetive,
        result_expected,
        description_activity,
        id_project,
        id_especific,
        id_user,
        id_project_result,
        id_project_activity
    ) VALUES (
        p_activity,
        p_date_start,
        p_date_end,
        p_place,
        p_participants_expected,
        p_objetive,
        p_result_expected,
        p_description_activity,
        p_id_project,
        p_id_especific,
        p_id_user,
        p_id_project_result,
        p_id_project_activity
    )
    RETURNING row_to_json(activities.*)::jsonb INTO v_result;
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read activity
CREATE OR REPLACE FUNCTION read_activity(
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(a.*)::jsonb INTO v_result
    FROM activities a
    WHERE id_activity = p_id_activity;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Actividad no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Update activity
CREATE OR REPLACE FUNCTION update_activity(
    p_id_activity UUID,
    p_activity varchar,
    p_date_start date,
    p_date_end date,
    p_place varchar,
    p_participants_expected smallint,
    p_objetive text,
    p_result_expected text,
    p_description_activity text,
    p_id_project UUID,
    p_id_especific UUID,
    p_id_user UUID,
    p_id_project_result UUID,
    p_id_project_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE activities
    SET activity = p_activity,
        date_start = p_date_start,
        date_end = p_date_end,
        place = p_place,
        participants_expected = p_participants_expected,
        objetive = p_objetive,
        result_expected = p_result_expected,
        description_activity = p_description_activity,
        id_project = p_id_project,
        id_especific = p_id_especific,
        id_user = p_id_user,
        id_project_result = p_id_project_result,
        id_project_activity = p_id_project_activity
    WHERE id_activity = p_id_activity
    RETURNING row_to_json(activities.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Actividad no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Delete activity
CREATE OR REPLACE FUNCTION delete_activity(
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM activities
    WHERE id_activity = p_id_activity
    RETURNING row_to_json(activities.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Actividad no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- List all activities
CREATE OR REPLACE FUNCTION list_activities()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM activities ORDER BY date_start
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List activities by project
CREATE OR REPLACE FUNCTION list_activities_by_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM activities WHERE id_project = p_id_project ORDER BY date_start
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List activities by user
CREATE OR REPLACE FUNCTION list_activities_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM activities WHERE id_user = p_id_user ORDER BY date_start
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
