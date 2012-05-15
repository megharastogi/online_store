# modulraize it so that variable_name need not be passed again n again

def verify_belongs_to variable_name, *associations
  associations.each do |association| 
    it "should belong to a #{association}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should belong_to(association)
    end
  end
end
def verify_has_many variable_name, *associations
  associations.each do |association| 
    it "should have many #{association}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should have_many(association)
    end
  end
end
def verify_has_one variable_name, *associations
  associations.each do |association| 
    it "should have one #{association}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should have_one(association)
    end
  end
end

def verify_has_and_belongs_to_many variable_name, *associations
  associations.each do |association| 
    it "should has and belongs to many #{association}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should have_and_belong_to_many(association)
    end
  end
end
