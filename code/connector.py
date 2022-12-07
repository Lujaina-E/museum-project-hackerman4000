""" the password to all acounts except guest is 'password' """
""" the usernames are: admin, employee or guest"""

import mysql.connector

table = {
    "ARTIST": ["ARTISTNAME", "DATEBORN", "DATEDIED", "ORIGINCOUNTRY", "EPOCH", "ARTISTDESCR", "MAINSTYLE"],
    "ARTOBJECT": ["IDNUM", "EPOCH", "ORIGIN", "CREATIONYEAR", "TITLE", "ITEMDESCRIPTION", "ARTTYPE", "STYLE", "MATERIAL", "HEIGHT", "WEIGHT", "DRAWNON", "PAINTTYPE", "ARTISTNAME", "OTHERTYPE"],
    "PERMANENT": ["IDNUM", "ITEMSTATUS", "ITEMCOST", "DATEAQUIRED"],
    "COLLECTION": ["COLLECTIONNAME", "COLLECTIONTYPE", "CLCTDESCRIPTION", "ADDRESS", "PHONE", "CONTACTPERSON"],
    "BORROWED": ["IDNUM", "DATEBORROWED", "DATERETURNED", "COLLECTIONNAME"],
    "EXHIBTION": ["EXBNNAME", "STARTDATE", "ENDDATE"],
    "DISPLAYS": ["OBJECTIDNUM", "EXBNNAME"]
}

illegal = ["ARTISTNAME", "IDNUM", "COLLECTIONNAME", "EXBNNAME", "OBJECTIDNUM"]
parent = ["ARTIST", "ARTOBJECT", "COLLECTION", "EXHIBITION"]
    
def guest():
    keys = list(table.keys())
    level = 1
    table_choice = ''
    attribute_choice = []
    num_attributes = 1
    distinct = ''
    condition_statement = ''
    while level <= 5:
        if level == 1:
            counter = 0
            for i in keys:
                print(f'{counter + 1}. {keys[counter]}')
                counter += 1
            try:
                table_choice = keys[int(input('Please enter the table you would like view: ')) - 1]
                level += 1
            except IndexError:
                print("Not one of the options")
        
        if level == 2:
            back = input('Would you like to go back? (Y/N): ').upper()
            if back == 'Y':
                level -= 1
                continue
            
            num_attributes = input(f'Input the amount of attributes (input * for all). Maximum {len(table[table_choice])}: ')
            if(num_attributes == '*'):
                attribute_choice.append('*')
                level += 1
                continue
            else:
                num_attributes = int(num_attributes)
            
            counter = 1
            for i in table[table_choice]:
                print(f'{counter}. {i}')
                counter += 1
            
            for i in range(num_attributes):  
                column = int(input('Please input an attribute you would like to see: '))
                attribute_choice.append(table[table_choice][column - 1])
            print(attribute_choice)
            level += 1
        
        if level == 3:
            back = input('Would you like to go back? (Y/N): ').upper()
            if back == 'Y':
                level -= 1
                continue
            num_condition = int(input('Please input the amount of conditions for the query: '))
            if num_condition > 0:
                condition_statement = input("Please input your condition exactly how it will be placed into the sql statement()(ex. IDNum = 29746): ").upper()
                for i in range(num_condition - 1):
                    connection = input('AND or OR: ').upper()
                    condition = input("Please input your condition exactly how it will be placed into the sql statement()(ex. IDNum = 29746): ").upper()
                    condition_statement = f"{condition_statement} {connection} {condition}"
            level += 1
        
        if level == 4:
            back = input('Would you like to go back? (Y/N): ').upper()
            if back == 'Y':
                level -= 1
                continue
            distinct = input('Do you only want distinct values/combinations? (Y/N): ').upper()
            level += 1
        
        if level == 5:
            back = input('Would you like to go back? (Y/N): ').upper()
            if back == 'Y':
                level -= 1
                continue
            break
    
    if distinct == 'Y':
        sql = "SELECT"
    else:
        sql = "SELECT DISTINCT"
    
    for i in range(num_attributes):
        if i < num_attributes - 1:
            sql = f"{sql} {attribute_choice[i]},"
        else:
            sql = f"{sql} {attribute_choice[i]}"
    if num_condition > 0:
        sql = f"{sql} FROM {table_choice} WHERE {condition_statement}" 
    else:
        sql = f"{sql} FROM {table_choice}"
    
    cur.execute(sql)
    rows = cur.fetchall()
    size = len(rows)
    for i in range(size):
        for j in range(len(rows[i])):
            formatted = str(rows[i][j])
            formatted =(formatted).ljust(20)
            print(formatted, end=" ")
        print()
        
def admin():
    print('1. Type in SQL command')
    print('2. Run SQL script')
    choice = int(input('Input option you would like to do: '))
    
    if choice == 1:
        sql = input('Input SQL command\n')
        cur.execute(sql)
    
    if choice == 2:
        file_name = input('Please input filename: ')
        fd = open(file_name, 'r')
        sql_file = fd.read()
        fd.close()
        sql_commands = sql_file.split(';')
        for command in sql_commands:
            cur.execute(command)
            print(f'{command}   Successful')
        print("Commands Successful")
    
    cnxn.commit()

def employee():
    print('1. Lookup info in database')
    print('2. Insert')
    print('3. Update')
    print('4. Delete')
    choice = int(input('Input option you would like to do: '))
    table_choice = ''
    
    if choice == 1:
        condition_statement = ""
        sql = ""
        attribute_choice = []
        table_choice = str(input('Please input a table you wish to lookup: ')).upper()
        num_attributes = input(f'Input the amount of attributes (input * for all). Maximum {len(table[table_choice])}: ')
        if(num_attributes == '*'):
            attribute_choice.append('*')
            num_attributes = 1
        else:
            num_attributes = int(num_attributes)
            for i in range(num_attributes):
                attribute_choice.append(input("Please input the attribute you wish to SELECT from the table: ").upper())
        num_condition = int(input('Please input the amount of conditions for the query: '))
        if num_condition > 0:
            condition_statement = input("Please input your condition exactly how it will be placed into the sql statement()(ex. IDNum = 29746): ").upper()
            for i in range(num_condition - 1):
                connection = input('AND or OR: ').upper()
                condition = input("Please input your condition exactly how it will be placed into the sql statement()(ex. IDNum = 29746): ").upper()
                condition_statement = f"{condition_statement} {connection} {condition}"
    
        distinct = input('Do you only want distinct values/combinations? (Y/N): ').upper()
        if distinct == 'Y':
            sql = "SELECT"
        else:
            sql = "SELECT DISTINCT"
        
        for i in range(num_attributes):
            if i < num_attributes - 1:
                sql = f"{sql} {attribute_choice[i]},"
            else:
                sql = f"{sql} {attribute_choice[i]}"
        if num_condition > 0:
            sql = f"{sql} FROM {table_choice} WHERE {condition_statement}" 
        else:
            sql = f"{sql} FROM {table_choice}"
        
        cur.execute(sql)
        rows = cur.fetchall()
        size = len(rows)
        for i in range(size):
            for j in range(len(rows[i])):
                formatted = str(rows[i][j])
                formatted =(formatted).ljust(20)
                print(formatted, end=" ")
            print()

    if choice == 2:
        table_choice = input('Input table you would like to insert into: ')
        while table_choice not in list(table.keys()):
            table_choice = input('Input table you would like to insert into: ')
        
        print('1. Insert using file')
        print('2. Insert through prompts')
        choice = int(input('Input option you would like to do: '))
        
        if choice == 1:
            file_name = input('Please input filename: ')
            fd = open(file_name, 'r')
            sql_file = fd.read()
            fd.close()
            sql_commands = sql_file.splitlines()
            for command in sql_commands:
                cur.execute(command)
                print(f'{command}   Row Inserted')
        
        if choice == 2:
            loops = int(input('Input the amount of items you want to insert: '))
            for i in range(loops):
                inp = []
                sql = "INSERT INTO " + table_choice + " ("
                for i in range(len(table[table_choice])):
                    inp.append(input(f"Please enter {table[table_choice][i]}: "))
                    if i <= len(table[table_choice]) - 2:  
                        sql = sql + table[table_choice][i] + ", "
                sql = sql + table[table_choice][len(table[table_choice])-1]
                sql = sql + ") VALUES ("
                for i in range(len(table[table_choice])-1):
                    sql = sql + "%s, "
                sql = sql + "%s)"
                data = tuple(inp)
                cur.execute(sql, data)
                print('Row Inserted')
                
    if choice == 3:
        inp = []
        value_choice = input('Please enter the column which you want to update: ').upper()
        if value_choice in illegal or value_choice not in table[table_choice]:
            print("Invalid attribute")
            return
        num_key = int(input('Please type in the number of primary keys in this table: '))
        key = []
        #build sql statement based on user input
        for i in range(num_key):
            key.append(input('Please enter name of primary key: ').upper())
        inp.append(input(f'Please enter new value of {value_choice}: '))
        sql = "UPDATE " + table_choice + " SET " + value_choice + " = %s WHERE "
        for i in range(len(key)):
            inp.append(input(f'Please enter value of primary key {key[i]}: '))
            if i < len(key) - 1:
                sql = sql + key[i] + " = %s AND "
            else:
                sql = sql + key[i] + " = %s"
                
        val = tuple(inp)
        cur.execute(sql, val)
        print('Item Updated')
        
    if choice == 4:
        table_choice = str(input("Please input the table you wish to delete from: ")).upper()
        if table_choice in parent:
            print('Table contains parent keys cannot delete from table')
            return
        
        num_key = int(input('Please input the number of attributes to use to search: '))
        search = []
        val = []
        
        for i in range(num_key):
            attribute_choice = input('Please enter name of search attribute: ').upper()
            attribute_val = input('Please enter the value to be deleted: ').upper()
            search.append(attribute_choice)
            val.append(attribute_val)
        
        sql = "DELETE FROM " + table_choice + " WHERE "
        for i in range(num_key):
            if i < num_key - 1:
                sql = f"{sql}{search[i]} = '{val[i]}' AND"
            else:
                sql = f"{sql} {search[i]} = '{val[i]}'"
                
        cur.execute(sql)
        print('row deleted')
    
    cnxn.commit()

if __name__ == '__main__':
    print('Welcome to the database please login!')
    users = ['admin', 'guest', 'employee', 'root']
    connection_user = ''
    connection_pass = ''
    while connection_user not in users:
        connection_user = input('Username(if guest type in guest): ').lower()
        if connection_user not in users:
            continue
        if connection_user != 'guest':
            connection_pass = input('Password: ')
    connection_db = 'artmuseum'


    cnxn = mysql.connector.connect(
        host="127.0.0.1",
        port=3306,
        database=connection_db,
        user=connection_user,
        password=connection_pass)

    cur = cnxn.cursor()
    
    if connection_user == 'guest':
        guest()
    if connection_user == 'admin':
        admin()
    if connection_user == 'employee':
        employee()
        
    while True:
        choice = input('Do you want to continue? (Y/N): ').upper()
        if choice == 'Y':
            if connection_user == 'guest':
                guest()
            if connection_user == 'admin':
                admin()
            if connection_user == 'employee':
                employee()
        else:
            break
    
    cnxn.close()
