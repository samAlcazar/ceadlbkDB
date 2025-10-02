-- Create quantitative
CREATE OR REPLACE FUNCTION create_quantitative(
    p_achieved smallint,
    p_day date,
    p_sp_female smallint,
    p_sp_male smallint,
    p_f_female smallint,
    p_f_male smallint,
    p_na_female smallint,
    p_na_male smallint,
    p_p_female smallint,
    p_p_male smallint,
    p_id_activity UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    INSERT INTO quantitatives (
        achieved,
        day,
        sp_female,
        sp_male,
        f_female,
        f_male,
        na_female,
        na_male,
        p_female,
        p_male,
        id_activity,
        id_user
    ) VALUES (
        p_achieved,
        p_day,
        p_sp_female,
        p_sp_male,
        p_f_female,
        p_f_male,
        p_na_female,
        p_na_male,
        p_p_female,
        p_p_male,
        p_id_activity,
        p_id_user
    )
    RETURNING row_to_json(quantitatives.*)::jsonb INTO v_result;
    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Read quantitative
CREATE OR REPLACE FUNCTION read_quantitative(
    p_id_quantitative UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT row_to_json(q.*)::jsonb INTO v_result
    FROM quantitatives q
    WHERE id_quantitative = p_id_quantitative;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Registro cuantitativo no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Update quantitative
CREATE OR REPLACE FUNCTION update_quantitative(
    p_id_quantitative UUID,
    p_achieved smallint,
    p_day date,
    p_sp_female smallint,
    p_sp_male smallint,
    p_f_female smallint,
    p_f_male smallint,
    p_na_female smallint,
    p_na_male smallint,
    p_p_female smallint,
    p_p_male smallint,
    p_id_activity UUID,
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    UPDATE quantitatives
    SET achieved = p_achieved,
        day = p_day,
        sp_female = p_sp_female,
        sp_male = p_sp_male,
        f_female = p_f_female,
        f_male = p_f_male,
        na_female = p_na_female,
        na_male = p_na_male,
        p_female = p_p_female,
        p_male = p_p_male,
        id_activity = p_id_activity,
        id_user = p_id_user
    WHERE id_quantitative = p_id_quantitative
    RETURNING row_to_json(quantitatives.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Registro cuantitativo no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- Delete quantitative
CREATE OR REPLACE FUNCTION delete_quantitative(
    p_id_quantitative UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    DELETE FROM quantitatives
    WHERE id_quantitative = p_id_quantitative
    RETURNING row_to_json(quantitatives.*)::jsonb INTO v_result;
    RETURN COALESCE(v_result, jsonb_build_object('message', 'Registro cuantitativo no encontrado'));
END;
$$ LANGUAGE plpgsql;

-- List all quantitatives
CREATE OR REPLACE FUNCTION list_quantitatives()
RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(q.*))
    INTO v_result
    FROM (
        SELECT * FROM quantitatives ORDER BY day
    ) q;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List quantitatives by activity
CREATE OR REPLACE FUNCTION list_quantitatives_by_activity(
    p_id_activity UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(q.*))
    INTO v_result
    FROM (
        SELECT * FROM quantitatives WHERE id_activity = p_id_activity ORDER BY day
    ) q;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;

-- List quantitatives by user
CREATE OR REPLACE FUNCTION list_quantitatives_by_user(
    p_id_user UUID
) RETURNS jsonb AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(q.*))
    INTO v_result
    FROM (
        SELECT * FROM quantitatives WHERE id_user = p_id_user ORDER BY day
    ) q;
    RETURN COALESCE(v_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql;
