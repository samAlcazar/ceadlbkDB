-- Create accountability
CREATE OR REPLACE FUNCTION create_accountability(
    p_amount numeric,
    p_reception varchar,
    p_approved boolean,
    p_id_project UUID,
    p_id_user UUID,
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO accountabilities (
        amount,
        reception,
        approved,
        id_project,
        id_user,
        id_activity
    ) VALUES (
        p_amount,
        p_reception,
        p_approved,
        p_id_project,
        p_id_user,
        p_id_activity
    )
    RETURNING row_to_json(accountabilities.*)::jsonb INTO v_result;
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read accountability
CREATE OR REPLACE FUNCTION read_accountability(
    p_id_accountability UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(a.*)::jsonb INTO v_result
    FROM accountabilities a
    WHERE id_accountability = p_id_accountability;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Rendición no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Update accountability

CREATE OR REPLACE FUNCTION update_accountability(
    p_id_accountability UUID,
    p_amount numeric,
    p_reception varchar,
    p_approved boolean,
    p_id_project UUID,
    p_id_user UUID,
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE accountabilities
    SET amount = p_amount,
        reception = p_reception,
        approved = p_approved,
        id_project = p_id_project,
        id_user = p_id_user,
        id_activity = p_id_activity
    WHERE id_accountability = p_id_accountability
    RETURNING row_to_json(accountabilities.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Rendición no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Delete accountability
CREATE OR REPLACE FUNCTION delete_accountability(
    p_id_accountability UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM accountabilities
    WHERE id_accountability = p_id_accountability
    RETURNING row_to_json(accountabilities.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Rendición no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- List all accountabilities
CREATE OR REPLACE FUNCTION list_accountabilities()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM accountabilities ORDER BY presentation
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List accountabilities by project
CREATE OR REPLACE FUNCTION list_accountabilities_by_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM accountabilities WHERE id_project = p_id_project ORDER BY presentation
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List accountabilities by user
CREATE OR REPLACE FUNCTION list_accountabilities_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM accountabilities WHERE id_user = p_id_user ORDER BY presentation
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List accountabilities by activity
CREATE OR REPLACE FUNCTION list_accountabilities_by_activity(
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM accountabilities WHERE id_activity = p_id_activity ORDER BY presentation
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
