USE db1;
# switch to session 1
ALTER TABLE t ENGINE = InnoDB;
# OK
# switch to session 1
ALTER TABLE t ENGINE = InnoDB;
# OK
