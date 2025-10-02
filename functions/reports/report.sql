-- Create report
CREATE OR REPLACE FUNCTION create_report(
    p_issues text,
    p_results text,
    p_obstacle text,
    p_conclusions text,
    p_anexos text,
    p_approved boolean,
    p_id_user UUID,
    p_id_project UUID,
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO reports (
        issues,
        results,
        obstacle,
        conclusions,
        anexos,
        approved,
        id_user,
        id_project,
        id_activity
    ) VALUES (
        p_issues,
        p_results,
        p_obstacle,
        p_conclusions,
        p_anexos,
        p_approved,
        p_id_user,
        p_id_project,
        p_id_activity
    )
    RETURNING row_to_json(reports.*)::jsonb INTO v_result;
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read report
CREATE OR REPLACE FUNCTION read_report(
    p_id_report UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(r.*)::jsonb INTO v_result
    FROM reports r
    WHERE id_report = p_id_report;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Reporte no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Update report
CREATE OR REPLACE FUNCTION update_report(
    p_id_report UUID,
    p_issues text,
    p_results text,
    p_obstacle text,
    p_conclusions text,
    p_anexos text,
    p_approved boolean,
    p_id_user UUID,
    p_id_project UUID,
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE reports
    SET issues = p_issues,
        results = p_results,
        obstacle = p_obstacle,
        conclusions = p_conclusions,
        anexos = p_anexos,
        approved = p_approved,
        id_user = p_id_user,
        id_project = p_id_project,
        id_activity = p_id_activity
    WHERE id_report = p_id_report
    RETURNING row_to_json(reports.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Reporte no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Delete report
CREATE OR REPLACE FUNCTION delete_report(
    p_id_report UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM reports
    WHERE id_report = p_id_report
    RETURNING row_to_json(reports.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Reporte no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- List all reports
CREATE OR REPLACE FUNCTION list_reports()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(r.*))
    INTO v_result
    FROM (
        SELECT * FROM reports ORDER BY presentation
    ) r;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List reports by project
CREATE OR REPLACE FUNCTION list_reports_by_project(
    p_id_project UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(r.*))
    INTO v_result
    FROM (
        SELECT * FROM reports WHERE id_project = p_id_project ORDER BY presentation
    ) r;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List reports by user
CREATE OR REPLACE FUNCTION list_reports_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(r.*))
    INTO v_result
    FROM (
        SELECT * FROM reports WHERE id_user = p_id_user ORDER BY presentation
    ) r;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
