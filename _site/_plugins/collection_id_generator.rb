module Jekyll
  class CollectionIdGenerator < Generator
    safe true

    # Adds an 'id' and 'date' attribute to each document in every collection if it doesn't have
    # them in the YAML Front Matter already.
    def generate(site)
      site.collections.each_pair do |key, value|
        site.data[key] = {}

        value.docs.each do |doc|
          doc.data['id'] = File.basename(doc.path, File.extname(doc.path)) unless doc.data['id']
          doc.data['date'] = File.mtime(doc.path).strftime("%FT%T%:z") unless doc.data['date']

          site.data[key.to_s][doc.data['id']] = doc
        end
      end
    end
  end
end