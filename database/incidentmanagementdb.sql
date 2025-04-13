
ALTER TABLE notification ADD CONSTRAINT fk_notification_id 
FOREIGN KEY (user_id) REFERENCES user(user_id);


