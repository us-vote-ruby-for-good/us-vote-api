class VotingMethodsTransformer 
  attr_reader :dirty_array

  def initialize(dirty_hash)
    @dirty_array = dirty_hash["table_rows"]
  end
  
  def retrieve_state_info(state)
    remove_blank_values(state_hash[state])
  end

  def state_hash
    # takes the array of state options and turns it into a hash with
    # the state as the key and the options as a hash of options
    @state_hash ||= begin
                      @dirty_array.each_with_object({}) do |state_hash, hsh|
                        state_name = state_hash.delete("state")
                        hsh[state_name] = state_hash  
                      end
                    end
  end

  def remove_blank_values(unparsed_hash)
    hnew = Hash.new
    unparsed_hash.each do |key, val|
      if val.length <= 1 
        hnew[key] = "none"
      elsif val.include?("✓")
        hnew[key] = "yes"
      else
        hnew[key] = val
      end
    end
    hnew
  end
end

