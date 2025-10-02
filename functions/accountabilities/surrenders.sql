-- Create surrender
CREATE OR REPLACE FUNCTION create_surrender(
    p_date_invoice date,
    p_invoice_number varchar,
    p_code varchar,
    p_description text,
    p_import_usd numeric,
    p_import_bob numeric,
    p_id_accountability UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO surrenders (
        date_invoice,
        invoice_number,
        code,
        description,
        import_usd,
        import_bob,
        id_accountability,
        id_user
    ) VALUES (
        p_date_invoice,
        p_invoice_number,
        p_code,
        p_description,
        p_import_usd,
        p_import_bob,
        p_id_accountability,
        p_id_user
    )
    RETURNING row_to_json(surrenders.*)::jsonb INTO v_result;
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read surrender
CREATE OR REPLACE FUNCTION read_surrender(
    p_id_surrender UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(s.*)::jsonb INTO v_result
    FROM surrenders s
    WHERE id_surrender = p_id_surrender;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Rendición de cuenta no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Update surrender
CREATE OR REPLACE FUNCTION update_surrender(
    p_id_surrender UUID,
    p_date_invoice date,
    p_invoice_number varchar,
    p_code varchar,
    p_description text,
    p_import_usd numeric,
    p_import_bob numeric,
    p_id_accountability UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE surrenders
    SET date_invoice = p_date_invoice,
        invoice_number = p_invoice_number,
        code = p_code,
        description = p_description,
        import_usd = p_import_usd,
        import_bob = p_import_bob,
        id_accountability = p_id_accountability,
        id_user = p_id_user
    WHERE id_surrender = p_id_surrender
    RETURNING row_to_json(surrenders.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Rendición de cuenta no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- Delete surrender
CREATE OR REPLACE FUNCTION delete_surrender(
    p_id_surrender UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM surrenders
    WHERE id_surrender = p_id_surrender
    RETURNING row_to_json(surrenders.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Rendición de cuenta no encontrada'));
END;
$$ LANGUAGE plpgsql;

-- List all surrenders
CREATE OR REPLACE FUNCTION list_surrenders()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(s.*))
    INTO v_result
    FROM (
        SELECT * FROM surrenders ORDER BY date_invoice
    ) s;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List surrenders by accountability
CREATE OR REPLACE FUNCTION list_surrenders_by_accountability(
    p_id_accountability UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(s.*))
    INTO v_result
    FROM (
        SELECT * FROM surrenders WHERE id_accountability = p_id_accountability ORDER BY date_invoice
    ) s;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List surrenders by user
CREATE OR REPLACE FUNCTION list_surrenders_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(s.*))
    INTO v_result
    FROM (
        SELECT * FROM surrenders WHERE id_user = p_id_user ORDER BY date_invoice
    ) s;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
