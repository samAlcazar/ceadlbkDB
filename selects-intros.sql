SELECT * FROM super_user;
SELECT * FROM profiles;
SELECT * FROM applications;
SELECT * FROM users


INSERT INTO super_user(nick, password) VALUES ('ceadl'::character varying, 'a1b2c3d4c0'::character varying);
SELECT create_profile ('CEADL'::character varying, 'ceadl'::character varying);
SELECT create_user (
		'Centro de Estudios y Apoyo al Desarrollo Local'::character varying,
		'ceadl'::character varying,
		'a1b2c3d4c0'::character varying,
		'ONG'::character varying,
		'CEADL-ONG'::character varying,
		'CEADL'::character varying,
		'ceadl'::character varying,
		'All projects'::character varying
	);

SELECT * FROM accountabilities;