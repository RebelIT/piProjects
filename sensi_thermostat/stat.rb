require "sensi"
require "influxdb"
require_relative './secrets.rb'

class CollectStat
  def main
    device = connect(ENV['sensi_user'],ENV['sensi_pw'])
    db_connect = connect_db(ENV['db'])
    thermostat_name = device.DeviceName

    unless device.nil? || db_connect.nil?
      thermostat_stats = collect_stats(device)

      unless thermostat_stats.nil?
          send_stats(thermostat_stats,db_connect,thermostat_name)

      end
    end
  end

  def connect (user, pw)
    thermostat = Sensi::Thermostat.new(user, pw)
    thermostat.connect
    return thermostat
  rescue
    return nil
  end

  def connect_db (db)
    influxdb = InfluxDB::Client.new db
    return influxdb
  rescue
    return nil
  end

  def collect_stats(thermostat)
    stats = {
      "mode" => thermostat.system_mode,
      "temp" => thermostat.temperature,
      "set_temp" => thermostat.system_temperature,
      "humidity" => thermostat.humidity,
      "system_enabled" => thermostat.system_on?.to_s,
      "fan_enabled" => thermostat.system_fan_on?.to_s,
      "System_running" => thermostat.system_active?.to_s,
      "runtime" => thermostat.active_time
    }
    stats
  end

  def send_stats(stats,db,name)
    name = 'home_furnace'

    stats.each do |key,value|
      data = {values: { "#{{key}}": "#{value}" },tags:{ location: "#{{name}}" }}
      db.write_point(name, data)
      #puts data
    end
  end

end

CollectStat.new.main
