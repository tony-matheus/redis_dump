def getEmployersDump
  employers = ''
  1.upto(10) do |i|
    salary = getSalary()
    employers = employers + "HMSET empregado:#{i} name #{getRandomName()} desc \"FullStack Developer\" salary #{salary} cod_dep #{Random.rand(1..2)}\n"
    employers = employers + "ZADD empregado_salary #{salary} empregado:#{i}\n"
  end
  employers
end

def getDepartamentDump
  departaments = ''
  1.upto(5) do |i|
    departaments = departaments + "HMSET departamento:#{i} name #{getRandomDepartament()} \n"
  end
  departaments
end

def getRandomName
  names = ["Tony", "Andre", "Daeuble", "Victor"]
  rand_number = Random.rand(1..names.length) - 1
  names[rand_number]
end

def getSalary
  values = [1000, 3000, 2000, 4000]
  rand_number = Random.rand(1..values.length) - 1
  values[rand_number]
end

def getRandomDepartament
  deps = ["TI","Atacado","Auditoria","Comercial","Credito","Legal","Manutencao","Marketing","Sales","RH","Varejo","Operações","Seguros","Tesouraria","Fiscal","Garantia","Sanitaria","Festas","Money"]
  rand_number = Random.rand(1..deps.length) - 1

  value = deps[rand_number]
  deps.delete(rand_number)
  value
end


def generateDumpData
  dump = getEmployersDump()
  dump = dump + "\n\n" +getDepartamentDump()

  writeFile("redisInsertDump.txt", dump)
end

def generateClearDump
  clear_dump = ''
  1.upto(10) do |i|
    clear_dump = clear_dump + "DEL empregado:#{i}\n"
  end

  1.upto(2) do |i|
    clear_dump = clear_dump + "DEL departamento:#{i}\n"
  end
  writeFile("redisClearDump.txt", clear_dump)
end

def generateSelectCMDs
  selects = "HGETALL departamento:4\n" # select * from departamento where id = 4
  selects = selects + "ZRANGEBYSCORE empregado_salary < 3000\n" # select * from empregado where salary  4
  selects = selects + "keys departamento*\n" # select * from departamento

  writeFile("redisSelectCMD.txt", selects)
end

def writeFile file_name, value
  File.delete file_name
  File.write(file_name, value)
end

generateDumpData()
generateClearDump()
generateSelectCMDs()
