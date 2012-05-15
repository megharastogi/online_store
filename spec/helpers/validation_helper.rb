
def verify_validate_presence_of variable_name, *attributes
  attributes.each do |attribute| 
    it "should validate presence of #{attribute}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should validate_presence_of(attribute)
    end
  end
end

def verify_validate_presence_of_only_on_update variable_name, *attributes
  attributes.each do |attribute| 
    it "should validate presence of #{attribute} only on update" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should validate_presence_of(attribute)
    end
  end
end

def verify_validate_uniqueness_of variable_name, *attributes
  attributes.each do |attribute| 
    it "should validate uniqueness of #{attribute}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should validate_uniqueness_of(attribute)
    end
  end
end

def verify_validate_inclusion_of variable_name, *attributes
  attributes.each do |attribute| 
    it "should validate inclusion of #{attribute}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should validate_inclusion_of(attribute)
    end
  end
end

def verify_validate_numericality_of variable_name, *attributes
  attributes.each do |attribute| 
    it "should validate numericality of #{attribute}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should validate_numericality_of(attribute)
    end
  end
end

def verify_validate_email variable_name, *attributes
  attributes.each do |attribute| 
    it "should validate format of #{attribute}" do
      variable = instance_variable_get("@#{variable_name}")
      variable.should validate_email(attribute)
    end
  end
end

def verify_validate_length_of variable_name, attribute, options = {}
  it "should validate length of #{attribute}" do
    variable = instance_variable_get("@#{variable_name}")
    variable.should validate_length_of(attribute, options)
  end
end

def verify_validate_confirmation_of variable_name, attribute
  it "should validate confirmation of #{attribute}" do
    variable = instance_variable_get("@#{variable_name}")
    variable.should validate_confirmation_of(attribute)
  end
end
