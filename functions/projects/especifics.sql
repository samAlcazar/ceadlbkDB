-- Create especific
CREATE OR REPLACE FUNCTION create_especific(
    p_num_especific smallint,
    p_especific text,
    p_id_user UUID,
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO especifics (
        num_especific,
        especific,
        id_user,
        id_project
    ) VALUES (
        p_num_especific,
        p_especific,
        p_id_user,
        p_id_project
    )
    RETURNING row_to_json(especifics.*)::jsonb INTO v_result;
    
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read especific
CREATE OR REPLACE FUNCTION read_especific(
    p_id_especific UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(e.*)::jsonb INTO v_result
    FROM especifics e
    WHERE id_especific = p_id_especific;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Especificación no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Update especific
CREATE OR REPLACE FUNCTION update_especific(
    p_id_especific UUID,
    p_num_especific smallint,
    p_especific text,
    p_id_user UUID,
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE especifics
    SET num_especific = p_num_especific,
        especific = p_especific,
        id_user = p_id_user,
        id_project = p_id_project
    WHERE id_especific = p_id_especific
    RETURNING row_to_json(especifics.*)::jsonb INTO v_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Especificación no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Delete especific
CREATE OR REPLACE FUNCTION delete_especific(
    p_id_especific UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM especifics
    WHERE id_especific = p_id_especific
    RETURNING row_to_json(especifics.*)::jsonb INTO v_result;
    
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Especificación no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- List all especifics
CREATE OR REPLACE FUNCTION list_especifics(
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(e.*))
    INTO v_result
    FROM (
        SELECT *
        FROM especifics
        ORDER BY num_especific
    ) e;
    
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List especifics by project
CREATE OR REPLACE FUNCTION list_especifics_by_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(e.*))
    INTO v_result
    FROM (
        SELECT *
        FROM especifics
        WHERE id_project = p_id_project
        ORDER BY num_especific
    ) e;
    
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List especifics by user
CREATE OR REPLACE FUNCTION list_especifics_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(e.*))
    INTO v_result
    FROM (
        SELECT *
        FROM especifics
        WHERE id_user = p_id_user
        ORDER BY num_especific
    ) e;
    
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;