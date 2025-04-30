# Crontab creator and validator for ATS EOD shutdown script
# This tool will take in the entries from the users for creating a crontab, and validate it for constrains of hours
# that can be set and the day of the week that can be set. If the said constrains are not met, an appropriate error will
# be thrown.
# Current allowed time for shutdown excludes
# - Rahul N.

def is_valid_hour(hour):
    return hour < 7 or hour > 20

def is_valid_day_of_week(dow):

    if (dow == '1-5' or dow == '1-6'):
        return True
    else:
        return False

def main():
    minute = raw_input("Enter minute (0-59): ")
    hour = int(raw_input("Enter hour (0-23): "))
    if not is_valid_hour(hour):
        print("Error: Hour must not be between 07 and 21 (7 AM to 9 PM).")
        return

    day_of_week = raw_input("Enter day of week (1-5 or 1-6, comma-separated): ")

    if not is_valid_day_of_week(day_of_week):
        print("Error: Day of week must be 1-5 or 1-6 (Monday to Friday/Saturday).")
        return

    command = "test me"

    cron_line = "%s %s * * %s %s" % (minute, hour, day_of_week, command)
    print("Cron entry:")
    print(cron_line)

if __name__ == "__main__":
    main()
