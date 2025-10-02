-- Create budget
CREATE OR REPLACE FUNCTION create_budget(
    p_quantity smallint,
    p_code varchar,
    p_description varchar,
    p_import_usd numeric,
    p_import_bob numeric,
    p_id_application UUID,
    p_id_founder UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO budgets (
        quantity,
        code,
        description,
        import_usd,
        import_bob,
        id_application,
        id_founder,
        id_user
    ) VALUES (
        p_quantity,
        p_code,
        p_description,
        p_import_usd,
        p_import_bob,
        p_id_application,
        p_id_founder,
        p_id_user
    )
    RETURNING row_to_json(budgets.*)::jsonb INTO v_result;
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read budget
CREATE OR REPLACE FUNCTION read_budget(
    p_id_budget UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(b.*)::jsonb INTO v_result
    FROM budgets b
    WHERE id_budget = p_id_budget;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Presupuesto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Update budget
CREATE OR REPLACE FUNCTION update_budget(
    p_id_budget UUID,
    p_quantity smallint,
    p_code varchar,
    p_description varchar,
    p_import_usd numeric,
    p_import_bob numeric,
    p_id_application UUID,
    p_id_founder UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE budgets
    SET quantity = p_quantity,
        code = p_code,
        description = p_description,
        import_usd = p_import_usd,
        import_bob = p_import_bob,
        id_application = p_id_application,
        id_founder = p_id_founder,
        id_user = p_id_user
    WHERE id_budget = p_id_budget
    RETURNING row_to_json(budgets.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Presupuesto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Delete budget
CREATE OR REPLACE FUNCTION delete_budget(
    p_id_budget UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM budgets
    WHERE id_budget = p_id_budget
    RETURNING row_to_json(budgets.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Presupuesto no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- List all budgets
CREATE OR REPLACE FUNCTION list_budgets()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(b.*))
    INTO v_result
    FROM (
        SELECT * FROM budgets ORDER BY code
    ) b;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List budgets by application
CREATE OR REPLACE FUNCTION list_budgets_by_application(
    p_id_application UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(b.*))
    INTO v_result
    FROM (
        SELECT * FROM budgets WHERE id_application = p_id_application ORDER BY code
    ) b;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List budgets by user
CREATE OR REPLACE FUNCTION list_budgets_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(b.*))
    INTO v_result
    FROM (
        SELECT * FROM budgets WHERE id_user = p_id_user ORDER BY code
    ) b;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List budgets by founder
CREATE OR REPLACE FUNCTION list_budgets_by_founder(
    p_id_founder UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(b.*))
    INTO v_result
    FROM (
        SELECT * FROM budgets WHERE id_founder = p_id_founder ORDER BY code
    ) b;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
