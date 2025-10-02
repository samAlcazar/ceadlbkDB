--TRIGERS
--AUDIT-PROFILE
--Audit create profile
CREATE OR REPLACE FUNCTION tg_create_profile()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_profile (id_user, action_audit_profile, table_audit_profile, last_audit_profile, new_audit_profile)
  VALUES (NEW.id_super_user, 'INSERTAR', 'PROFILE', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_profile
AFTER INSERT ON profiles
FOR EACH ROW EXECUTE PROCEDURE tg_create_profile();

--Audit update profile
CREATE OR REPLACE FUNCTION tg_update_profile()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_profile (id_user, action_audit_profile, table_audit_profile, last_audit_profile, new_audit_profile)
  VALUES (NEW.id_super_user, 'ACTUALIZAR', 'PROFILE', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_profile
AFTER UPDATE ON profiles
FOR EACH ROW EXECUTE PROCEDURE tg_update_profile();

--Audit delete profile
CREATE OR REPLACE FUNCTION tg_delete_profile()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_profile (id_user, action_audit_profile, table_audit_profile, last_audit_profile, new_audit_profile)
  VALUES (OLD.id_super_user, 'ELIMINAR', 'PROFILE', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_profile
BEFORE DELETE ON profiles
FOR EACH ROW EXECUTE PROCEDURE tg_delete_profile();

--Audit create user
CREATE OR REPLACE FUNCTION tg_create_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_profile (id_user, action_audit_profile, table_audit_profile, last_audit_profile, new_audit_profile)
  VALUES (NEW.id_user, 'INSERTAR', 'USER', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_user
AFTER INSERT ON users
FOR EACH ROW EXECUTE PROCEDURE tg_create_user();

--Audit update user
CREATE OR REPLACE FUNCTION tg_update_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_profile (id_user, action_audit_profile, table_audit_profile, last_audit_profile, new_audit_profile)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'USER', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_user
AFTER UPDATE ON users
FOR EACH ROW EXECUTE PROCEDURE tg_update_user();

--Audit delete user
CREATE OR REPLACE FUNCTION tg_delete_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_profile (id_user, action_audit_profile, table_audit_profile, last_audit_profile, new_audit_profile)
  VALUES (OLD.id_user, 'ELIMINAR', 'USER', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_user
BEFORE DELETE ON users
FOR EACH ROW EXECUTE PROCEDURE tg_delete_user();

--Audit create founder
CREATE OR REPLACE FUNCTION tg_create_founder()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (NEW.id_user, 'INSERTAR', 'FOUNDERS', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_founder
AFTER INSERT ON founders
FOR EACH ROW EXECUTE PROCEDURE tg_create_founder();

--Audit update founder
CREATE OR REPLACE FUNCTION tg_update_founder()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'FOUNDERS', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_founder
AFTER UPDATE ON founders
FOR EACH ROW EXECUTE PROCEDURE tg_update_founder();

--Audit delete founder
CREATE OR REPLACE FUNCTION tg_delete_founder()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (OLD.id_user, 'ELIMINAR', 'FOUNDERS', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_founder
BEFORE DELETE ON founders
FOR EACH ROW EXECUTE PROCEDURE tg_delete_founder();

--Audit create project
CREATE OR REPLACE FUNCTION tg_create_project()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (NEW.id_user, 'INSERTAR', 'PROJECTS', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_project
AFTER INSERT ON projects
FOR EACH ROW EXECUTE PROCEDURE tg_create_project();

--Audit update project
CREATE OR REPLACE FUNCTION tg_update_project()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'PROJECTS', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_project
AFTER UPDATE ON projects
FOR EACH ROW EXECUTE PROCEDURE tg_update_project();

--Audit delete project
CREATE OR REPLACE FUNCTION tg_delete_project()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (OLD.id_user, 'ELIMINAR', 'PROJECTS', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_project
BEFORE DELETE ON projects
FOR EACH ROW EXECUTE PROCEDURE tg_delete_project();

--Audit create especifics
CREATE OR REPLACE FUNCTION tg_create_especifics()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (NEW.id_user, 'INSERTAR', 'ESPECIFICS', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_especifics
AFTER INSERT ON especifics
FOR EACH ROW EXECUTE PROCEDURE tg_create_especifics();

--Audit update especifics
CREATE OR REPLACE FUNCTION tg_update_especifics()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'ESPECIFICS', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_especifics
AFTER UPDATE ON especifics
FOR EACH ROW EXECUTE PROCEDURE tg_update_especifics();

--Audit delete especifics
CREATE OR REPLACE FUNCTION tg_delete_especifics()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit (id_user, action_audit, table_audit, last_audit, new_audit)
  VALUES (OLD.id_user, 'ELIMINAR', 'ESPECIFICS', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_especifics
BEFORE DELETE ON especifics
FOR EACH ROW EXECUTE PROCEDURE tg_delete_especifics();

--AUDIT ACTIVITIES
--Audit create activity
CREATE OR REPLACE FUNCTION tg_create_activity()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'INSERTAR', 'ACTIVITIES', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_activity
AFTER INSERT ON activities
FOR EACH ROW EXECUTE PROCEDURE tg_create_activity();

--Audit update activities
CREATE OR REPLACE FUNCTION tg_update_activity()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'ACTIVITIES', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_activity
AFTER UPDATE ON activities
FOR EACH ROW EXECUTE PROCEDURE tg_update_activity();

--Audit delete activities
CREATE OR REPLACE FUNCTION tg_delete_activity()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (OLD.id_user, 'ELIMINAR', 'ACTIVITIES', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_activity
BEFORE DELETE ON activities
FOR EACH ROW EXECUTE PROCEDURE tg_delete_activity();

--Audit create reports
CREATE OR REPLACE FUNCTION tg_create_report()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'INSERTAR', 'REPORTS', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_report
AFTER INSERT ON reports
FOR EACH ROW EXECUTE PROCEDURE tg_create_report();

--Audit update reports
CREATE OR REPLACE FUNCTION tg_update_report()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'REPORTS', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_report
AFTER UPDATE ON reports
FOR EACH ROW EXECUTE PROCEDURE tg_update_report();

--Audit delete reports
CREATE OR REPLACE FUNCTION tg_delete_report()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (OLD.id_user, 'ELIMINAR', 'REPORTS', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_report
BEFORE DELETE ON reports
FOR EACH ROW EXECUTE PROCEDURE tg_delete_report();

--Audit create quantitative
CREATE OR REPLACE FUNCTION tg_create_quantitative()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'INSERTAR', 'QUANTITATIVES', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_quantitative
AFTER INSERT ON quantitatives
FOR EACH ROW EXECUTE PROCEDURE tg_create_quantitative();

--Audit update quantitative
CREATE OR REPLACE FUNCTION tg_update_quantitative()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'QUANTITATIVES', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_quantitative
AFTER UPDATE ON quantitatives
FOR EACH ROW EXECUTE PROCEDURE tg_update_quantitative();

--Audit delete quantitative
CREATE OR REPLACE FUNCTION tg_delete_quantitative()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (OLD.id_user, 'ELIMINAR', 'QUANTITATIVES', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_quantitative
BEFORE DELETE ON quantitatives
FOR EACH ROW EXECUTE PROCEDURE tg_delete_quantitative();

--Audit create application
CREATE OR REPLACE FUNCTION tg_create_application()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'INSERTAR', 'APPLICATIONS', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_application
AFTER INSERT ON applications
FOR EACH ROW EXECUTE PROCEDURE tg_create_application();

--Audit update application
CREATE OR REPLACE FUNCTION tg_update_application()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'APPLICATIONS', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_application
AFTER UPDATE ON applications
FOR EACH ROW EXECUTE PROCEDURE tg_update_application();

--Audit delete application
CREATE OR REPLACE FUNCTION tg_delete_application()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (OLD.id_user, 'ELIMINAR', 'APPLICATIONS', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_application
BEFORE DELETE ON applications
FOR EACH ROW EXECUTE PROCEDURE tg_delete_application();

--Audit create budget
CREATE OR REPLACE FUNCTION tg_create_budget()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'INSERTAR', 'BUDGETS', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_budget
AFTER INSERT ON budgets
FOR EACH ROW EXECUTE PROCEDURE tg_create_budget();

--Audit update budget
CREATE OR REPLACE FUNCTION tg_update_budget()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'BUDGETS', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_budget
AFTER UPDATE ON budgets
FOR EACH ROW EXECUTE PROCEDURE tg_update_budget();

--Audit delete budget
CREATE OR REPLACE FUNCTION tg_delete_budget()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (OLD.id_user, 'ELIMINAR', 'BUDGETS', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_budget
BEFORE DELETE ON budgets
FOR EACH ROW EXECUTE PROCEDURE tg_delete_budget();

--Audit create accountability
CREATE OR REPLACE FUNCTION tg_create_accountability()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'INSERTAR', 'ACCOUNTABILITIES', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_accountability
AFTER INSERT ON accountabilities
FOR EACH ROW EXECUTE PROCEDURE tg_create_accountability();

--Audit update accountability
CREATE OR REPLACE FUNCTION tg_update_accountability()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'ACCOUNTABILITIES', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_accountability
AFTER UPDATE ON accountabilities
FOR EACH ROW EXECUTE PROCEDURE tg_update_accountability();

--Audit delete accountability
CREATE OR REPLACE FUNCTION tg_delete_accountability()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (OLD.id_user, 'ELIMINAR', 'ACCOUNTABILITIES', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_accountability
BEFORE DELETE ON accountabilities
FOR EACH ROW EXECUTE PROCEDURE tg_delete_accountability();

--Audit create surrender
CREATE OR REPLACE FUNCTION tg_create_surrender()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'INSERTAR', 'SURRENDERS', NULL, row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_create_surrender
AFTER INSERT ON surrenders
FOR EACH ROW EXECUTE PROCEDURE tg_create_surrender();

--Audit update surrender
CREATE OR REPLACE FUNCTION tg_update_surrender()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (NEW.id_user, 'ACTUALIZAR', 'SURRENDERS', row_to_json(OLD), row_to_json(NEW));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_update_surrender
AFTER UPDATE ON surrenders
FOR EACH ROW EXECUTE PROCEDURE tg_update_surrender();

--Audit delete surrender
CREATE OR REPLACE FUNCTION tg_delete_surrender()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_activity (id_user, action_audit_activity, table_audit_activity, last_audit_activity, new_audit_activity)
  VALUES (OLD.id_user, 'ELIMINAR', 'SURRENDERS', row_to_json(OLD), NULL);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_delete_surrender
BEFORE DELETE ON surrenders
FOR EACH ROW EXECUTE PROCEDURE tg_delete_surrender();