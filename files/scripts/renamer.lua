remove_illegal_chars = false
replace_illegal_chars = true

local maxnamelen = 35
local animelanguage = Language.English
local episodelanguage = Language.English
local spacechar = " "

local group = ""
if (file.anidb and file.anidb.releasegroup) then
  group = "[" .. (file.anidb.releasegroup.shortname or file.anidb.releasegroup.name) .. "]"
end
local animename = anime:getname(animelanguage) or anime.preferredname

-- CUSTOM CONDITION HERE --
if anime.type == AnimeType.Movie then
    destination = "Anime Movies" -- MODIFY ACCORDING TO DESTINATION FOLDER
else
    destination = "Anime Shows" -- MODIFY ACCORDING TO DESTINATION FOLDER
end

local episodename = ""
local engepname = episode:getname(Language.English) or ""
local episodenumber = ""
-- If the episode is not a complete movie then add an episode number
if anime.type ~= AnimeType.Movie or not engepname:find("^Complete Movie") then
  local fileversion = ""
  if (file.anidb and file.anidb.version > 1) then
    fileversion = "v" .. file.anidb.version
  end
  -- Padding is determined from the number of episodes of the same type in the anime (#tostring() gives the number of digits required, e.g. 10 eps -> 2 digits)
  -- Padding is at least 2 digits
  local epnumpadding = math.max(#tostring(anime.episodecounts[episode.type]), 2)
  episodenumber = episode_numbers(epnumpadding) .. fileversion

  -- If this file is associated with a single episode and the episode doesn't have a generic name, then add the episode name
  if #episodes == 1 and not engepname:find("^Episode") and not engepname:find("^OVA") then
    episodename = episode:getname(episodelanguage) or ""
  end
end

local res = file.media.video.res or ""
local codec = file.media.video.codec or ""
local bitdepth = ""
if (file.media.video.bitdepth and file.media.video.bitdepth ~= 8) then
  bitdepth = file.media.video.bitdepth .. "bit"
end

local dublangs = from(file.media.audio):select("language"):distinct()
local sublangs = from(file.media.sublanguages):distinct()
local source = ""
local centag = ""
if (file.anidb) then
  source = file.anidb.source
  -- Censorship is only relevent if the anime is age restricted
  if (anime.restricted) then
    if (file.anidb.censored) then
      centag = "[CEN]"
    else
      centag = "[UNCEN]"
    end
  end
  -- Dub and sub languages from anidb are usually more accurate
  -- But will return a single unknown language if there is none, needs to be fixed in Shoko
  dublangs = from(file.anidb.media.dublanguages):distinct()
  sublangs = from(file.anidb.media.sublanguages):distinct()
end

local langtag = ""
local nonnativedublangs = dublangs:except({ Language.Japanese, Language.Chinese, Language.Korean, Language.Unknown })
if (nonnativedublangs:count() == 1 and dublangs:count() == 2) then
  langtag = "[DUAL-AUDIO]"
elseif (dublangs:count() > 2) then
  langtag = "[MULTI-AUDIO]"
elseif (nonnativedublangs:count() > 0) then
  langtag = "[DUB]"
end


local crchash = ""
-- CRC can be null if disabled in Shoko settings, so need to check it
if (file.hashes.crc) then
  crchash = "[" .. file.hashes.crc .. "]"
end

local fileinfo = "(" .. table.concat({ res, codec, bitdepth, source }, " "):cleanspaces(spacechar) .. ")"

local namelist = {
  group,
  animename:truncate(maxnamelen),
  episodenumber,
  episodename:truncate(maxnamelen),
  fileinfo,
  langtag,
  centag,
  crchash,
}

filename = table.concat(namelist, " "):cleanspaces(spacechar)
subfolder = { animename }