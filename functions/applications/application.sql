-- Create application
CREATE OR REPLACE FUNCTION create_application(
    p_amount numeric,
    p_approved boolean,
    p_id_project UUID,
    p_id_user UUID,
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO applications (
        amount,
        approved,
        id_project,
        id_user,
        id_activity
    ) VALUES (
        p_amount,
        p_approved,
        p_id_project,
        p_id_user,
        p_id_activity
    )
    RETURNING row_to_json(applications.*)::jsonb INTO v_result;
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read application
CREATE OR REPLACE FUNCTION read_application(
    p_id_application UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(a.*)::jsonb INTO v_result
    FROM applications a
    WHERE id_application = p_id_application;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Aplicación no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Update application
CREATE OR REPLACE FUNCTION update_application(
    p_id_application UUID,
    p_amount numeric,
    p_approved boolean,
    p_id_project UUID,
    p_id_user UUID,
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE applications
    SET amount = p_amount,
        approved = p_approved,
        id_project = p_id_project,
        id_user = p_id_user,
        id_activity = p_id_activity
    WHERE id_application = p_id_application
    RETURNING row_to_json(applications.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Aplicación no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Delete application
CREATE OR REPLACE FUNCTION delete_application(
    p_id_application UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM applications
    WHERE id_application = p_id_application
    RETURNING row_to_json(applications.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Aplicación no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- List all applications
CREATE OR REPLACE FUNCTION list_applications()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM applications ORDER BY presentation
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List applications by project
CREATE OR REPLACE FUNCTION list_applications_by_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM applications WHERE id_project = p_id_project ORDER BY presentation
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List applications by user
CREATE OR REPLACE FUNCTION list_applications_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM applications WHERE id_user = p_id_user ORDER BY presentation
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List applications by activity
CREATE OR REPLACE FUNCTION list_applications_by_activity(
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(a.*))
    INTO v_result
    FROM (
        SELECT * FROM applications WHERE id_activity = p_id_activity ORDER BY presentation
    ) a;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
