class Forest::LegalDocsController < ForestLiana::ApplicationController

  def index
    files = Forest::S3Helper.new.files('livedemo/legal')
    files = files.map { |f| build_legal_doc(f) }

    render json: JSONAPI::Serializer.serialize(files, is_collection: true)
  end

  def show
    file = Forest::S3Helper.new.file(params[:id])
    file = build_legal_doc(file)

    render json: JSONAPI::Serializer.serialize(file)
  end

  def update
    render body: 'You can only read data on this public demo application.',
      status: 403
  end

  def destroy
    render body: 'You can only read data on this public demo application.',
      status: 403
  end

  private
  
  def build_legal_doc(file)
    Forest::LegalDoc.new(
      id: file[:id],
      url: file[:url],
      last_modified: file[:last_modified],
      size: file[:size],
      is_verified: is_verified?(file)
    )
  end

  def is_verified?(file)
    document = Document.find_by(file_id: file[:id])
    document.is_verified if document
  end
end

