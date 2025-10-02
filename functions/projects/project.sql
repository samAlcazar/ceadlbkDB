-- Create project
CREATE OR REPLACE FUNCTION create_project(
    p_cod_project varchar(100),
    p_name_project varchar(200),
    p_objetive_project text,
    p_id_founder UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO projects (
        cod_project,
        name_project,
        objetive_project,
        id_founder,
        id_user
    ) VALUES (
        p_cod_project,
        p_name_project,
        p_objetive_project,
        p_id_founder,
        p_id_user
    )
    RETURNING row_to_json(projects.*)::jsonb INTO v_result;
    
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read project
CREATE OR REPLACE FUNCTION read_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(p.*)::jsonb INTO v_result
    FROM projects p
    WHERE id_project = p_id_project;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Proyecto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Update project
CREATE OR REPLACE FUNCTION update_project(
    p_id_project UUID,
    p_cod_project varchar(100),
    p_name_project varchar(200),
    p_objetive_project text,
    p_id_founder UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE projects
    SET cod_project = p_cod_project,
        name_project = p_name_project,
        objetive_project = p_objetive_project,
        id_founder = p_id_founder,
        id_user = p_id_user
    WHERE id_project = p_id_project
    RETURNING row_to_json(projects.*)::jsonb INTO v_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Proyecto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Delete project
CREATE OR REPLACE FUNCTION delete_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM projects
    WHERE id_project = p_id_project
    RETURNING row_to_json(projects.*)::jsonb INTO v_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Proyecto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- List all projects
CREATE OR REPLACE FUNCTION list_projects(
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(p.*))
    INTO v_result
    FROM (
        SELECT *
        FROM projects
        ORDER BY create_project DESC
    ) p;
    
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List projects by founder
CREATE OR REPLACE FUNCTION list_projects_by_founder(
    p_id_founder UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(p.*))
    INTO v_result
    FROM (
        SELECT *
        FROM projects
        WHERE id_founder = p_id_founder
        ORDER BY create_project DESC
    ) p;
    
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List projects by user
CREATE OR REPLACE FUNCTION list_projects_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(p.*))
    INTO v_result
    FROM (
        SELECT *
        FROM projects
        WHERE id_user = p_id_user
        ORDER BY create_project DESC
    ) p;
    
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
