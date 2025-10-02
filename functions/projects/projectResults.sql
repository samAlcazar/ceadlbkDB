-- Create project_result
CREATE OR REPLACE FUNCTION create_project_result(
    p_num_project_result smallint,
    p_project_result text,
    p_id_project UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO project_results (
        num_project_result,
        project_result,
        id_project,
        id_user
    ) VALUES (
        p_num_project_result,
        p_project_result,
        p_id_project,
        p_id_user
    )
    RETURNING row_to_json(project_results.*)::jsonb INTO v_result;
    
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read project_result
CREATE OR REPLACE FUNCTION read_project_result(
    p_id_project_result UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(pr.*)::jsonb INTO v_result
    FROM project_results pr
    WHERE id_project_result = p_id_project_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Resultado de proyecto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Update project_result
CREATE OR REPLACE FUNCTION update_project_result(
    p_id_project_result UUID,
    p_num_project_result smallint,
    p_project_result text,
    p_id_project UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE project_results
    SET num_project_result = p_num_project_result,
        project_result = p_project_result,
        id_project = p_id_project,
        id_user = p_id_user
    WHERE id_project_result = p_id_project_result
    RETURNING row_to_json(project_results.*)::jsonb INTO v_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Resultado de proyecto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Delete project_result
CREATE OR REPLACE FUNCTION delete_project_result(
    p_id_project_result UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM project_results
    WHERE id_project_result = p_id_project_result
    RETURNING row_to_json(project_results.*)::jsonb INTO v_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Resultado de proyecto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- List all project_results
CREATE OR REPLACE FUNCTION list_project_results()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(pr.*))
    INTO v_result
    FROM (
        SELECT * FROM project_results ORDER BY num_project_result
    ) pr;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List project_results by project
CREATE OR REPLACE FUNCTION list_project_results_by_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(pr.*))
    INTO v_result
    FROM (
        SELECT * FROM project_results WHERE id_project = p_id_project ORDER BY num_project_result
    ) pr;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List project_results by user
CREATE OR REPLACE FUNCTION list_project_results_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(pr.*))
    INTO v_result
    FROM (
        SELECT * FROM project_results WHERE id_user = p_id_user ORDER BY num_project_result
    ) pr;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
