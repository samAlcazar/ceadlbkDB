-- Create project_activity
CREATE OR REPLACE FUNCTION create_project_activity(
    p_num_project_activity smallint,
    p_project_activity text,
    p_category varchar,
    p_id_project UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO project_activities (
        num_project_activity,
        project_activity,
        category,
        id_project,
        id_user
    ) VALUES (
        p_num_project_activity,
        p_project_activity,
        p_category,
        p_id_project,
        p_id_user
    )
    RETURNING row_to_json(project_activities.*)::jsonb INTO v_result;
    
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read project_activity
CREATE OR REPLACE FUNCTION read_project_activity(
    p_id_project_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(pa.*)::jsonb INTO v_result
    FROM project_activities pa
    WHERE id_project_activity = p_id_project_activity;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Actividad de proyecto no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Update project_activity
CREATE OR REPLACE FUNCTION update_project_activity(
    p_id_project_activity UUID,
    p_num_project_activity smallint,
    p_project_activity text,
    p_category varchar,
    p_id_project UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE project_activities
    SET num_project_activity = p_num_project_activity,
        project_activity = p_project_activity,
        category = p_category,
        id_project = p_id_project,
        id_user = p_id_user
    WHERE id_project_activity = p_id_project_activity
    RETURNING row_to_json(project_activities.*)::jsonb INTO v_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Actividad de proyecto no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Delete project_activity
CREATE OR REPLACE FUNCTION delete_project_activity(
    p_id_project_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM project_activities
    WHERE id_project_activity = p_id_project_activity
    RETURNING row_to_json(project_activities.*)::jsonb INTO v_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Actividad de proyecto no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- List all project_activities
CREATE OR REPLACE FUNCTION list_project_activities()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(pa.*))
    INTO v_result
    FROM (
        SELECT * FROM project_activities ORDER BY num_project_activity
    ) pa;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List project_activities by project
CREATE OR REPLACE FUNCTION list_project_activities_by_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(pa.*))
    INTO v_result
    FROM (
        SELECT * FROM project_activities WHERE id_project = p_id_project ORDER BY num_project_activity
    ) pa;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List project_activities by user
CREATE OR REPLACE FUNCTION list_project_activities_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(pa.*))
    INTO v_result
    FROM (
        SELECT * FROM project_activities WHERE id_user = p_id_user ORDER BY num_project_activity
    ) pa;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
