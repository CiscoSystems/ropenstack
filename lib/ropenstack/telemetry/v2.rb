  ##
	# * Name: TelemetryVersion2
	# * Description: Implementation of the Telemetry V2.0 API Client in Ruby 
	# * Author: Sam 'Tehsmash' Betts, John Davidge
	# * Date: 30/06/2014
  ##
module TelemetryVersion2
  def alarms(id = nil)
    if id.nil?
      get_request(address("alarms"), @token)
    else
      get_request(address("alarms/"+id), @token)
    end
  end

  def alarm_create
    data = {}
    post_request(address("alarms"), data, @token)
  end

  def alarm_update
    data = {}
    put_request(address("alarms"), data, @token)
  end

  def alarm_delete(id)
    delete_request(address("alarms/"+id), @token)
  end

  def alarm_state(id)
    get_request(address("alarms/"+id+"/state"), @token)
  end

  def alarm_history(id)
    get_request(address("alarms/"+id+"/history"), @token)
  end

  def meters(name = nil)
    if name.nil?
      get_request(address("meters"), @token)
    else
      get_request(address("meters/"+name), @token)
    end
  end

  def send_samples(name)
    data = {}
    post_request(address("meters/"+name), data, @token)
  end

  def meter_statistics(meter)
    get_request(address("meters/"+name+"/statistics"), @token)
  end

  def resources(id = nil)
    if id.nil?
      get_request(address("resources"), @token)
    else
      get_request(address("resources/"+id), @token)
    end
  end

  def version
    "V2"
  end
end
