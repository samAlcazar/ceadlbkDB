--FUNCTIONS
--PROFILE
--Create profile
CREATE OR REPLACE FUNCTION create_profile (_profile character varying, _nick character varying)
RETURNS void
AS $$ BEGIN
    INSERT INTO profiles (profile, nick)
	VALUES (_profile, _nick);
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RAISE EXCEPTION 'No fue posible crear el perfil';
END
$$
LANGUAGE plpgSQL;

--Update profile
CREATE OR REPLACE FUNCTION update_profile (_id_profile smallint, _profile character varying, _nick character varying)
RETURNS void
AS $$ BEGIN
    IF _id_profile IS NOT NULL THEN
            UPDATE profiles SET profile = _profile, nick = _nick
            WHERE id_profile = _id_profile;
        ELSE RAISE EXCEPTION 'No fue posible actualizar el perfil';
    END IF;
END;
$$ LANGUAGE plpgsql;

--Delete profile
CREATE OR REPLACE FUNCTION delete_profile(_id_profile smallint)
RETURNS void
AS $$ BEGIN
	IF _id_profile IS NOT NULL THEN
		DELETE FROM profiles WHERE id_profile = _id_profile;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el perfil';
	END IF;
END;
$$ LANGUAGE plpgsql;

--FOUNDER
--Create founder
CREATE OR REPLACE FUNCTION create_founder (_cod_founder character varying, _name_founder character varying, _nick_user character varying)
RETURNS void
AS $$ BEGIN
    INSERT INTO founders (cod_founder, name_founder, nick_user)
	VALUES (_cod_founder, _name_founder, _nick_user);
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RAISE EXCEPTION 'No fue posible crear el perfil';
END
$$
LANGUAGE plpgSQL;

--Update founder
CREATE OR REPLACE FUNCTION update_founder (_id_founder smallint, _cod_founder character varying, _name_founder character varying, _nick_user character varying)
RETURNS void
AS $$ BEGIN
    IF _id_founder IS NOT NULL THEN
            UPDATE founders SET cod_founder = _cod_founder, name_founder = _name_founder, nick_user = _nick_user
            WHERE id_founder = _id_founder;
        ELSE RAISE EXCEPTION 'No se pudo actualizar el financiador';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete Founder
CREATE OR REPLACE FUNCTION delete_founder(_id_founder smallint)
RETURNS void
AS $$ BEGIN
	IF _id_founder IS NOT NULL THEN
		DELETE FROM founders WHERE id_founder = _id_founder;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el financiador';
	END IF;
END;
$$ LANGUAGE plpgsql;

--PROYECT
--Create proyect
CREATE OR REPLACE FUNCTION create_proyect (
    _cod_proyect character varying,
    _name_proyect character varying,
    _objetive text,
    _cod_founder character varying,
    _nick_user character varying
)
RETURNS void
AS $$ BEGIN
    INSERT INTO proyects (cod_proyect, name_proyect, objetive, cod_founder, nick_user)
	VALUES (_cod_proyect, _name_proyect, _objetive, _cod_founder, _nick_user);
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RAISE EXCEPTION 'No fue posible crear el proyecto';
END
$$
LANGUAGE plpgSQL;

--Update proyect
CREATE OR REPLACE FUNCTION update_proyect (
    _id_proyect smallint,
    _cod_proyect character varying,
    _name_proyect character varying,
    _objetive text,
    _cod_founder character varying,
    _nick_user character varying
)
RETURNS void
AS $$ BEGIN
    IF _id_proyect IS NOT NULL THEN
        UPDATE proyects SET 
            cod_proyect = _cod_proyect,
            name_proyect = _name_proyect,
            objetive = _objetive,
            cod_founder = _cod_founder,
            nick_user = _nick_user
        WHERE id_proyect = _id_proyect;
	    ELSE 
            RAISE EXCEPTION 'No fue posible actualizar el proyecto';
    END IF;
END;
$$
LANGUAGE plpgSQL;

--Delete proyect
CREATE OR REPLACE FUNCTION delete_proyect(_id_proyect smallint)
RETURNS void
AS $$ BEGIN
	IF _id_proyect IS NOT NULL THEN
		DELETE FROM proyects WHERE id_proyect = _id_proyect;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el proyecto';
	END IF;
END;
$$ LANGUAGE plpgsql;

--ESPECIFICS
--Create especific
CREATE OR REPLACE FUNCTION create_especific(
    _num_especific smallint,
    _especific text,
    _nick_user character varying,
    _name_proyect character varying
)
RETURNS void
AS $$ BEGIN
    INSERT INTO especifics (
        num_especific,
        especific,
        nick_user, 
        name_proyect
    )
    VALUES (
        _num_especific,
        _especific,
        _nick_user,
        _name_proyect
    );
    EXCEPTION
 	WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No fue posible crear el objetivo específico';
END;
$$ LANGUAGE plpgSQL;

--Update especific
CREATE OR REPLACE FUNCTION update_especific(
    _id_especific smallint,
    _num_especific smallint,
    _especific text,
    _nick_user character varying,
    _name_proyect character varying
)
RETURNS void
AS $$ BEGIN
    IF _id_especific IS NOT NULL THEN
        UPDATE especifics SET 
            num_especific = _num_especific,
            especific = _especific,
            nick_user = _nick_user,
            name_proyect = _name_proyect
        WHERE id_especific = _id_especific;
        ELSE RAISE EXCEPTION 'No se pudo actualizar el objetivo específico';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete especific
CREATE OR REPLACE FUNCTION delete_especific(_id_especific smallint)
RETURNS void
AS $$ BEGIN
	IF _id_especific IS NOT NULL THEN
		DELETE FROM especifics WHERE id_especific = _id_especific;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el proyecto';
	END IF;
END;
$$ LANGUAGE plpgsql;

--Create project results
CREATE OR REPLACE FUNCTION create_project_result(
	_num_project_result smallint,
	_project_result text,
	_name_proyect character varying,
    _nick_user character varying
)RETURNS void
AS $$ BEGIN
    INSERT INTO project_results (num_project_result, project_result, name_proyect, nick_user)
    VALUES (_num_project_result, _project_result, _name_proyect, _nick_user);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE EXCEPTION 'No se pudeo crear el resultado esperado del proyecto';
END;
$$
LANGUAGE plpgSQL;

--Update project results
CREATE OR REPLACE FUNCTION update_project_result(
    _id_project_result smallint,
    _num_project_result smallint,
	_project_result text,
	_name_proyect character varying,
    _nick_user character varying
)RETURNS void
AS $$ BEGIN
    IF _id_project_result IS NOT NULL THEN
    UPDATE project_results SET
        id_project_result = _id_project_result,
        num_project_result = _num_project_result,
        project_result = _project_result,
        name_proyect = _name_proyect,
        nick_user = _nick_user
    WHERE id_project_result = _id_project_result;
    ELSE RAISE EXCEPTION 'No fue posible actualizar el resultado';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete project results
CREATE OR REPLACE FUNCTION delete_project_result(_id_project_result smallint)
RETURNS void
AS $$ BEGIN
	IF _id_project_result IS NOT NULL THEN
		DELETE FROM project_results WHERE id_project_result = _id_project_result;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el resultado esperado del proyecto';
	END IF;
END;
$$ LANGUAGE plpgsql;

--Create project activity
CREATE OR REPLACE FUNCTION create_project_activity(
	_num_project_activity smallint,
	_project_activity character varying,
    _category character varying,
	_name_proyect character varying,
    _nick_user character varying
)RETURNS void
AS $$ BEGIN
    INSERT INTO project_activities (num_project_activity, project_activity, category, name_proyect, nick_user)
    VALUES (_num_project_activity, _project_activity, _category, _name_proyect, _nick_user);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE EXCEPTION 'No se pudeo crear la actividad del proyecto';
END;
$$
LANGUAGE plpgSQL;

--Update project activity
CREATE OR REPLACE FUNCTION update_project_activity(
    _id_project_activity smallint,
    _num_project_activity smallint,
	_project_activity text,
    _category character varying,
	_name_proyect character varying,
    _nick_user character varying
)RETURNS void
AS $$ BEGIN
    IF _id_project_activity IS NOT NULL THEN
    UPDATE project_activities SET
        id_project_activity = _id_project_activity,
        num_project_activity = _num_project_activity,
        project_activity = _project_activity,
        category = _category,
        name_proyect = _name_proyect,
        nick_user = _nick_user
    WHERE id_project_activity = _id_project_activity;
    ELSE RAISE EXCEPTION 'No fue posible actualizar el resultado';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete project activity
CREATE OR REPLACE FUNCTION delete_project_activity(_id_project_activity smallint)
RETURNS void
AS $$ BEGIN
	IF _id_project_activity IS NOT NULL THEN
		DELETE FROM project_activities WHERE id_project_activity = _id_project_activity;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el resultado esperado del proyecto';
	END IF;
END;
$$ LANGUAGE plpgsql;

--USERS
--Create user
CREATE OR REPLACE FUNCTION create_user(
    _name_user character varying,
    _nick_user character varying,
    _password_user character varying,
	_charge_user character varying,
    _signature character varying,
	_profile character varying,
    _nick character varying,
	_name_proyect character varying
) RETURNS void
AS $$ BEGIN
	INSERT INTO users (name_user, nick_user, password_user, charge, signature, profile, nick, name_proyect)
	VALUES (_name_user,	_nick_user, PGP_SYM_ENCRYPT(_password_user,'AES_KEY'), _charge_user, _signature, _profile, _nick, _name_proyect);
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RAISE EXCEPTION 'No fue posible crear el usuario';
END
$$
LANGUAGE plpgSQL;

--Update user
CREATE OR REPLACE FUNCTION update_user(
    _id_user smallint,
    _name_user character varying,
    _nick_user character varying,
    _password_user character varying,
	_charge_user character varying,
    _signature character varying,
	_profile character varying,
    _nick character varying,
	_name_proyect character varying
) RETURNS void
AS $$ BEGIN
    IF _id_user IS NOT NULL THEN
        UPDATE users SET
            id_user = _id_user,
            name_user = _name_user,
            nick_user = _nick_user,
            password_user = PGP_SYM_ENCRYPT(_password_user,'AES_KEY'),
            charge = _charge_user,
            signature = _signature,
            profile = _profile,
            nick = _nick,
			name_proyect = _name_proyect
        WHERE id_user = _id_user;
    ELSE RAISE EXCEPTION 'No fue posible actualizar el usuario';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete user
CREATE OR REPLACE FUNCTION delete_user(_id_user smallint)
RETURNS void
AS $$ BEGIN
	IF _id_user IS NOT NULL THEN
		DELETE FROM users WHERE id_user = _id_user;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el proyecto';
	END IF;
END;
$$ LANGUAGE plpgsql;

--ACTIVITIES
--Create activitie
CREATE OR REPLACE FUNCTION create_activity (
    _activity character varying,
    _date_start character varying,
    _date_end character varying,
    _place character varying,
    _expected smallint,
    _objetive text,
    _result_expected text,
    _description text,
    _name_proyect character varying,
    _cod_founder character varying,
    _especific text,
    _nick_user character varying,
    _project_result text,
    _project_activity text
) RETURNS void
AS $$ BEGIN
    INSERT INTO activities (
        activity,
        date_start,
        date_end,
        place,
        expected,
        objetive,
        result_expected,
        description,
        name_proyect,
        cod_founder,
        especific,
        nick_user,
        project_result,
        project_activity
    )
    VALUES (
        _activity,
        _date_start,
        _date_end,
        _place,
        _expected,
        _objetive,
        _result_expected,
        _description,
        _name_proyect,
        _cod_founder,
        _especific,
        _nick_user,
        _project_result,
        _project_activity
    );
    EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RAISE EXCEPTION 'No fue posible crear la actividad';
END;
$$ LANGUAGE plpgSQL;

--Update activity
CREATE OR REPLACE FUNCTION update_activity (
    _id_activity smallint,
    _activity character varying,
    _date_start character varying,
    _date_end character varying,
    _place character varying,
    _expected smallint,
    _objetive text,
    _result_expected text,
    _description text,
    _name_proyect character varying,
    _cod_founder character varying,
    _especific text,
    _nick_user character varying,
    _project_result text,
    _project_activity text
) RETURNS void
AS $$ BEGIN
    IF _id_activity IS NOT NULL THEN
        UPDATE activities SET
            activity = _activity,
            date_start = _date_start,
            date_end = _date_end,
            place = _place,
            expected = _expected,
            objetive = _objetive,
            result_expected = _result_expected,
            description = _description,
            name_proyect = _name_proyect,
            cod_founder = _cod_founder,
            especific = _especific,
            nick_user = _nick_user,
            project_result = _project_result,
            project_activity = _project_activity
        WHERE id_activity = _id_activity;
    ELSE RAISE EXCEPTION 'No se pudo actualizar la actividad';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete activity
CREATE OR REPLACE FUNCTION delete_activity(_id_activity smallint)
RETURNS void
AS $$ BEGIN
	IF _id_activity IS NOT NULL THEN
		DELETE FROM activities WHERE id_activity = _id_activity;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el proyecto';
	END IF;
END;
$$ LANGUAGE plpgsql;

--REPORTS
--Create report
CREATE OR REPLACE FUNCTION create_report(
    _issues text,
    _results text,
    _obstacle text,
    _conclusions text,
    _anexos text,
	_approved boolean,
    _name_user character varying,
    _name_proyect character varying,
    _signature character varying,
    _cod_founder character varying,
    _nick_user character varying,
    _id_activity smallint
) RETURNS text
AS $$ BEGIN
    INSERT INTO reports (
        issues,
        results,
        obstacle,
        conclusions,
        anexos,
		approved,
        name_user,
        name_proyect,
        signature,
        cod_founder,
        nick_user,
        id_activity
    )
    VALUES (
        _issues,
        _results,
        _obstacle,
        _conclusions,
        _anexos,
		_approved,
        _name_user,
        _name_proyect,
        _signature,
        _cod_founder,
        _nick_user,
        _id_activity
    );
    RETURN 'Succsesfuly';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No fue posible crear el informe';
END;
$$ LANGUAGE plpgSQL;

--Update report
CREATE OR REPLACE FUNCTION update_report(
    _id_report smallint,
    _issues text,
    _results text,
    _obstacle text,
    _conclusions text,
    _anexos text,
	_approved boolean,
    _name_user character varying,
    _name_proyect character varying,
    _signature character varying,
    _cod_founder character varying,
    _nick_user character varying,
    _id_activity smallint
) RETURNS text
AS $$ BEGIN
    IF _id_report IS NOT NULL THEN
        UPDATE reports SET
            issues = _issues,
            results = _results,
            obstacle = _obstacle,
            conclusions = _conclusions,
            anexos = _anexos,
			approved = _approved,
            name_user = _name_user,
            name_proyect = _name_proyect,
            signature = _signature,
            cod_founder = _cod_founder,
            nick_user = _nick_user,
            id_activity = _id_activity
        WHERE id_report = _id_report;
        RETURN 'Succsesfuly';
    ELSE RAISE EXCEPTION 'No se pudo actualizar el informe';
    END IF;
END
$$ LANGUAGE plpgSQL;

--Delete report
CREATE OR REPLACE FUNCTION delete_report(_id_report smallint)
RETURNS void
AS $$ BEGIN
	IF _id_report IS NOT NULL THEN
		DELETE FROM reports WHERE id_report = _id_report;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el proyecto';
	END IF;
END;
$$ LANGUAGE plpgsql;

--QUANTITATIVE
--Create quantitative
CREATE OR REPLACE FUNCTION create_quantitative (
    _achieved smallint,
    _day character varying,
    _sp_female smallint,
    _sp_male smallint,
    _f_female smallint,
    _f_male smallint,
    _na_female smallint,
    _na_male smallint,
    _p_female smallint,
    _p_male smallint,
    _id_activity smallint,
    _nick_user character varying
) RETURNS text
AS $$ BEGIN
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
        nick_user
    )
    VALUES (
        _achieved,
        _day,
        _sp_female,
        _sp_male,
        _f_female,
        _f_male,
        _na_female,
        _na_male,
        _p_female,
        _p_male,
        _id_activity,
        _nick_user
    );
    RETURN 'Succesfuly';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No fue posible crear los datos cuantitativos';
END;
$$ LANGUAGE plpgSQL;

--Update quantitative
CREATE OR REPLACE FUNCTION update_quantitative (
    _id_quantitative smallint,
    _achieved smallint,
    _day character varying,
    _sp_female smallint,
    _sp_male smallint,
    _f_female smallint,
    _f_male smallint,
    _na_female smallint,
    _na_male smallint,
    _p_female smallint,
    _p_male smallint,
    _id_activity smallint,
    _nick_user character varying
) RETURNS text
AS $$ BEGIN
    IF _id_quantitative IS NOT NULL THEN
        UPDATE quantitatives SET 
            achieved = _achieved,
            day = _day,
            sp_female = _sp_female,
            sp_male = _sp_male,
            f_female = _f_female,
            f_male = _f_male,
            na_female = _na_female,
            na_male = _na_male,
            p_female = _p_female,
            p_male = _p_male,
            id_activity = _id_activity,
            nick_user = _nick_user
        WHERE id_quantitative = _id_quantitative;
        RETURN 'Succesfuly';
    ELSE RAISE EXCEPTION 'No se puedo actualizar los datos cuantitativos';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete quantitative
CREATE OR REPLACE FUNCTION delete_quantitative(_id_quantitative smallint)
RETURNS void
AS $$ BEGIN
	IF _id_quantitative IS NOT NULL THEN
		DELETE FROM quantitatives WHERE id_quantitative = _id_quantitative;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el proyecto';
	END IF;
END;
$$ LANGUAGE plpgsql;

--Delete quantitatives
CREATE OR REPLACE FUNCTION delete_quantitatives(_id_activity smallint)
RETURNS void
AS $$ BEGIN
	IF _id_quantitative IS NOT NULL THEN
		DELETE FROM quantitatives WHERE id_quantitative = _id_quantitative;
	ELSE
		RAISE EXCEPTION 'No se eliminaron los datos cuantitativos';
	END IF;
END;
$$ LANGUAGE plpgsql;

--APLICATIONS
--Create application
CREATE OR REPLACE FUNCTION create_application (
    _amount smallint,
	_approved boolean,
    _name_proyect character varying,
    _signature character varying,
    _name_user character varying,
    _nick_user character varying,
    _id_activity smallint
) RETURNS text
AS $$ BEGIN
    INSERT INTO applications (
        amount,
		approved,
        name_proyect,
        signature,
        name_user,
        nick_user,
        id_activity
    )
    VALUES (
        _amount,
		_approved,
        _name_proyect,
        _signature,
        _name_user,
        _nick_user,
        _id_activity
    );
    RETURN 'Succesfuly';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No fue posible crear la solicitud de fondos';
END;
$$ LANGUAGE plpgSQL;

--Update application
CREATE OR REPLACE FUNCTION update_application (
    _id_application smallint,
    _amount smallint,
	_approved boolean,
    _name_proyect character varying,
    _signature character varying,
    _name_user character varying,
    _nick_user character varying,
    _id_activity smallint
) RETURNS text
AS $$ BEGIN
    IF _id_application IS NOT NULL THEN
        UPDATE applications SET
            amount = _amount,
			approved = _approved,
            name_proyect = _name_proyect,
            signature = _signature,
            name_user = _name_user,
            nick_user = _nick_user,
            id_activity = _id_activity
        WHERE id_application = _id_application;
        RETURN 'Succsesfuly';
        ELSE RAISE EXCEPTION 'No se pudo actualizar la solicitud de fondos';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete application
CREATE OR REPLACE FUNCTION delete_application(_id_application smallint)
RETURNS void
AS $$ BEGIN
	IF _id_application IS NOT NULL THEN
		DELETE FROM applications WHERE id_application = _id_application;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar la solicitud de fondos';
	END IF;
END;
$$ LANGUAGE plpgsql;

--Update approved

CREATE OR REPLACE FUNCTION update_approved_application(_id_application smallint, _approved boolean)
RETURNS text
AS $$ BEGIN
    IF _id_application IS NOT NULL THEN
        UPDATE applications SET
            approved = _approved
        WHERE id_application = _id_application;
        RETURN 'successfully';
        ELSE RAISE EXCEPTION 'No se pudo aprovar la solicitud';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--BUDGETS
--Create budget
CREATE OR REPLACE FUNCTION create_budget (
    _quantity smallint,
    _code character varying,
    _description character varying,
    _import_usd smallint,
    _import_bob smallint,
    _id_activity smallint,
    _cod_founder character varying,
    _nick_user character varying
) RETURNS text
AS $$ BEGIN
    INSERT INTO budgets (
        quantity,
        code,
        description,
        import_usd,
        import_bob,
        id_activity,
        cod_founder,
        nick_user
    )
    VALUES (
        _quantity,
        _code,
        _description,
        _import_usd,
        _import_bob,
        _id_activity,
        _cod_founder,
        _nick_user
    );
    RETURN 'Succesfuly';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No fue posible crear el detalle de la solicitud de fondos';
END;
$$ LANGUAGE plpgSQL;

--Update budget
CREATE OR REPLACE FUNCTION update_budget (
    _id_budget smallint,
    _quantity smallint,
    _code character varying,
    _description character varying,
    _import_usd smallint,
    _import_bob smallint,
    _id_activity smallint,
    _cod_founder character varying,
    _nick_user character varying
) RETURNS text
AS $$ BEGIN
    IF _id_budget IS NOT NULL THEN
        UPDATE budgets SET
            quantity = _quantity,
            code = _code,
            description = _description,
            import_usd = _import_usd,
            import_bob = _import_bob,
            id_activity = _id_activity,
            cod_founder = _cod_founder,
            nick_user = _nick_user
        WHERE id_budget = _id_budget;
        RETURN 'Succsesfuly';
        ELSE RAISE EXCEPTION 'No se pudo actualizar el detalle de la solicitud de fondos';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete budget
CREATE OR REPLACE FUNCTION delete_budget(_id_budget smallint)
RETURNS void
AS $$ BEGIN
	IF _id_budget IS NOT NULL THEN
		DELETE FROM budgets WHERE id_budget = _id_budget;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el detalle de la solicitud de fondos';
	END IF;
END;
$$ LANGUAGE plpgsql;

--Delete budget
CREATE OR REPLACE FUNCTION delete_budgets(_id_activity smallint)
RETURNS void
AS $$ BEGIN
	IF _id_activity IS NOT NULL THEN
		DELETE FROM budgets WHERE id_activity = _id_activity;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el detalle de la solicitud de fondos';
	END IF;
END;
$$ LANGUAGE plpgsql;

--ACCOUNTABILITIES
CREATE OR REPLACE FUNCTION create_accountability (
    _amount smallint,
    _reception character varying,
    _cod_founder character varying,
    _name_proyect character varying,
    _signature character varying,
    _name_user character varying,
    _nick_user character varying,
    _id_activity smallint,
	_approved boolean
) RETURNS text
AS $$ BEGIN
    INSERT INTO accountabilities (
        amount,
        reception,
        cod_founder,
        name_proyect,
        signature,
        name_user,
        nick_user,
        id_activity,
		approved
    )
    VALUES (
        _amount,
        _reception,
        _cod_founder,
        _name_proyect,
        _signature,
        _name_user,
        _nick_user,
        _id_activity,
		_approved
    );
    RETURN 'Succesfuly';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No fue posible crear la rendición de cuentas';
END;
$$ LANGUAGE plpgSQL;

--Update accountability
CREATE OR REPLACE FUNCTION update_accountability (
    _id_accountability smallint,
    _amount smallint,
    _reception character varying,
    _cod_founder character varying,
    _name_proyect character varying,
    _signature character varying,
    _name_user character varying,
    _nick_user character varying,
    _id_activity smallint,
	_approved boolean
) RETURNS text
AS $$ BEGIN
    IF _id_accountability IS NOT NULL THEN
        UPDATE accountabilities SET
            amount = _amount,
            reception = _reception,
            cod_founder = _cod_founder,
            name_proyect = _name_proyect,
            signature = _signature,
            name_user = _name_user,
            nick_user = _nick_user,
            id_activity = _id_activity,
			approved = _approved
        WHERE id_accountability = _id_accountability;
        RETURN 'Succsesfuly';
        ELSE RAISE EXCEPTION 'No se pudo actualizar la rendición de cuentas';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete accountability
CREATE OR REPLACE FUNCTION delete_accountability(_id_accountability smallint)
RETURNS void
AS $$ BEGIN
	IF _id_accountability IS NOT NULL THEN
		DELETE FROM accountabilities WHERE id_accountability = _id_accountability;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el detalle de la solicitud de fondos';
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_approved_accountability(_id_accountability smallint, _approved boolean)
RETURNS text
AS $$ BEGIN
    IF _id_accountability IS NOT NULL THEN
        UPDATE accountabilities SET
            approved = _approved
        WHERE id_accountability = _id_accountability;
        RETURN 'successfully';
        ELSE RAISE EXCEPTION 'No se pudo aprovar la solicitud';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--SURRENDERS
--Create surrender

CREATE OR REPLACE FUNCTION create_surrender (
    _date_invoice character varying,
    _invoice_number character varying,
    _code character varying,
    _description text ,
    _inport_usd smallint,
    _inport_bob smallint,
    _id_activity smallint,
    _nick_user character varying
) RETURNS text
AS $$ BEGIN
    INSERT INTO surrenders (
        date_invoice,
        invoice_number,
        code,
        description,
        inport_usd,
        inport_bob,
        id_activity,
        nick_user
    )
    VALUES (
        _date_invoice,
        _invoice_number,
        _code,
        _description,
        _inport_usd,
        _inport_bob,
        _id_activity,
        _nick_user
    );
    RETURN 'Succesfuly';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No fue posible crear el detalle de la rendición de cuentas';
END;
$$ LANGUAGE plpgSQL;

--Update surrender
CREATE OR REPLACE FUNCTION update_surrender (
    _id_surrender smallint,
    _date_invoice character varying,
    _invoice_number character varying ,
    _code character varying,
    _description text ,
    _inport_usd smallint,
    _inport_bob smallint,
    _id_activity smallint,
    _nick_user character varying
) RETURNS text
AS $$ BEGIN
    IF _id_surrender IS NOT NULL THEN
        UPDATE surrenders SET
            date_invoice = _date_invoice,
            invoice_number = _invoice_number,
            code = _code,
            description = _description,
            inport_usd = _inport_usd,
            inport_bob = _inport_bob,
            id_activity = _id_activity,
            nick_user = _nick_user
        WHERE id_surrender = _id_surrender;
        RETURN 'Succsesfuly';
        ELSE RAISE EXCEPTION 'No se pudo actualizar el detalle de la rendición de cuentas';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete surrender
CREATE OR REPLACE FUNCTION delete_surrender(_id_surrender smallint)
RETURNS void
AS $$ BEGIN
	IF _id_surrender IS NOT NULL THEN
		DELETE FROM surrenders WHERE id_surrender = _id_surrender;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el detalle de la rendición de cuentas';
	END IF;
END;
$$ LANGUAGE plpgsql;

--Delete surrenders
CREATE OR REPLACE FUNCTION delete_surrenders(_id_activity smallint)
RETURNS void
AS $$ BEGIN
	IF _id_activity IS NOT NULL THEN
		DELETE FROM surrenders WHERE id_activity = _id_activity;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el detalle de la rendición de cuentas';
	END IF;
END;
$$ LANGUAGE plpgsql;

--Validate User
CREATE OR REPLACE FUNCTION validate_user (_nick_user character varying, _password_user character varying) RETURNS TABLE (name_user character varying, profile character varying, signature character varying, name_proyect character varying)
AS $$ DECLARE
  user_nick users.nick_user%TYPE;
  user_password users.password_user%TYPE;
BEGIN
  SELECT nick_user, pgp_sym_decrypt(password_user::bytea,'AES_KEY') INTO user_nick, user_password FROM users
  WHERE nick_user = _nick_user;
  IF _password_user = user_password THEN
    RETURN QUERY
    SELECT
      u.name_user,
      u.profile,
	  u.signature,
	  u.name_proyect
    FROM users u
    WHERE u.nick_user = _nick_user;
  ELSE RAISE EXCEPTION 'El usuario no existe';
  END IF;
END;
$$ LANGUAGE plpgSQL;

-- Create Base de datos

CREATE OR REPLACE FUNCTION create_data_base_participants (
	_name_participant character varying,
	_gender character varying,
	_age smallint,
	_organization character varying,
	_phone character varying,
	_type_participant character varying,
	_name_proyect character varying,
	_cod_founder character varying,
	_activity character varying,
	_nick_user character varying,
    _municipality character varying,
    _type_organization character varying
) RETURNS text
AS $$ BEGIN
    INSERT INTO data_base_participants (
        name_participant,
		gender,
		age,
		organization,
		phone,
		type_participant,
		name_proyect,
        cod_founder,
		activity,
		nick_user,
        municipality,
        type_organization
    )
    VALUES (
        _name_participant,
		_gender,
		_age,
		_organization,
		_phone,
		_type_participant,
		_name_proyect,
        _cod_founder,
		_activity,
		_nick_user,
        _municipality,
        _type_organization
    );
    RETURN 'Successfully';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No fue posible crear el item en la base de datos';
END;
$$ LANGUAGE plpgSQL;

--Update Base de datos
CREATE OR REPLACE FUNCTION update_data_base_participants (
    _id_participant smallint,
    _name_participant character varying,
	_gender character varying,
	_age smallint,
	_organization character varying,
	_phone character varying,
	_type_participant character varying,
	_name_proyect character varying,
	_cod_founder character varying,
	_activity character varying,
	_nick_user character varying,
    _municipality character varying,
    _type_organization character varying
) RETURNS text
AS $$ BEGIN
    IF _id_participant IS NOT NULL THEN
        UPDATE data_base_participants SET
            name_participant = _name_participant,
            gender = _gender,
            age = _age,
            organization = _organization,
            phone = _phone,
            type_participant = _type_participant,
            name_proyect = _name_proyect,
            cod_founder = _cod_founder,
            activity = _activity,
            nick_user = _nick_user,
            municipality = _municipality,
            type_organization = _type_organization
        WHERE id_participant = _id_participant;
        RETURN 'Succsesfuly';
        ELSE RAISE EXCEPTION 'No se pudo actualizar el item en la base de datos';
    END IF;
END;
$$ LANGUAGE plpgSQL;

--Delete Base de datos
CREATE OR REPLACE FUNCTION delete_data_base_participants (_id_participant smallint)
RETURNS void
AS $$ BEGIN
	IF _id_participant IS NOT NULL THEN
		DELETE FROM data_base_participants WHERE id_participant = _id_participant;
	ELSE
		RAISE EXCEPTION 'No se pudo eliminar el item de la base de datos';
	END IF;
END;
$$ LANGUAGE plpgsql;