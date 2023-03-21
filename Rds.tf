resource "aws_db_subnet_group" "db-sec-group" {
  name       = "rds-sec-group"
  subnet_ids = [aws_subnet.private-1a.id, aws_subnet.private-1b.id]

  tags = {
    Name = "rds-sec-group-${var.mytag}"
  }
}

resource "aws_db_instance" "db-instance" {
  allocated_storage      = 10
  max_allocated_storage  = 50
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "1234567890"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db-sec-group.name
  identifier             = "mydatabase1"
  port                   = 3306
  vpc_security_group_ids = [aws_security_group.db-sec-grp.id]
  publicly_accessible    = false

  # Maintenance window is after backup window, and on Sunday, and in the middle of the night.
  maintenance_window = "sun:09:00-sun:10:00"

  # We like backup retention for as long as possible.
  backup_retention_period = "7"

  # Backup window time in UTC is in the middle of the night in the United States.
  backup_window = "08:00-09:00"

  # We prefer to preserve the backups if the database is accidentally deleted.
  delete_automated_backups = "false"
}