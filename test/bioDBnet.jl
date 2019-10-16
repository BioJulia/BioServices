@testset "bioDBnet" begin
    @testset "db2db" begin
        # test #1 - json
        res = bioDBnet.db2db(input="DrugBankDrugId",
            outputs = ["PubChemId","KeggDrugId"],values = ["DB00316","DB00945"],
            taxonid = "9606")
        @test res.status == 200
        @test startswith(Dict(res.headers)["Content-Type"], "application/json")
        body = JSON.parse(String(res.body))
        @test isa(body, Array{Any,1})
        @test isa(body[1], Dict{String, Any})

        sleep(0.5)
        # test #2 - xml
        res = bioDBnet.db2db(input = "DrugBankDrugId",
            outputs = ["PubChemId","KeggDrugId"],values = ["DB00316","DB00945"],
            taxonid = "9606", rettype = "xml")
        @test res.status == 200
        @test startswith(Dict(res.headers)["Content-Type"], "application/xml")
        body = XMLDict.parse_xml(String(res.body))
        @test isa(body, XMLDict.XMLDictElement)
        @test first(body)[1] != "ERROR"
    end

    @testset "dbwalk" begin
        # test #1 - json
        res = bioDBnet.dbwalk(values=["DB00316","DB00945"],
            db_path = ["DrugBankDrugId","PubChemId","KeggDrugId"],
            taxonid = "9606", rettype = "json")
        @test res.status == 200
        @test startswith(Dict(res.headers)["Content-Type"], "application/json")
        body = JSON.parse(String(res.body))
        @test isa(body, Array{Any,1})
        @test isa(body[1], Dict{String, Any})

        sleep(0.5)
        # test #2 - xml
        res = bioDBnet.dbwalk(values = ["DB00316","DB00945"],
            db_path = ["DrugBankDrugId","PubChemId","KeggDrugId"],
            taxonid = "9606", rettype = "xml")
        @test res.status == 200
        @test startswith(Dict(res.headers)["Content-Type"], "application/xml")
        body = XMLDict.parse_xml(String(res.body))
        @test isa(body, XMLDict.XMLDictElement)
        @test first(body)[1] != "ERROR"

    end

    @testset "dbreport" begin
        # test #1 - json
        res = bioDBnet.dbreport(input="DrugBankDrugId",
            values = ["DB00316","DB00945"], taxonid = "9606",
            rettype = "json")
        @test res.status == 200
        @test startswith(Dict(res.headers)["Content-Type"], "application/json")
        body = JSON.parse(String(res.body))
        @test isa(body, Array{Any,1})
        @test isa(body[1], Dict{String, Any})

        sleep(0.5)
        # test #2 - xml
        res = bioDBnet.dbreport(input="DrugBankDrugId",
            values = ["DB00316","DB00945"], taxonid = "9606",
            rettype = "xml")
        @test res.status == 200
        @test startswith(Dict(res.headers)["Content-Type"], "application/xml")
        body = XMLDict.parse_xml(String(res.body))
        @test isa(body, XMLDict.XMLDictElement)
        @test first(body)[1] != "ERROR"
    end

    @testset "dbfind" begin
        #test1 - json
        res = bioDBnet.dbfind(values = ["DB00316","DB00945"],
            output = "KeggDrugId", taxonid = "9606", rettype = "json")
        @test res.status == 200
        @test startswith(Dict(res.headers)["Content-Type"], "application/json")
        body = JSON.parse(String(res.body))
        @test isa(body, Array{Any,1})
        @test isa(body[1], Dict{String, Any})

        sleep(0.5)
        # test #2 - xml
        res = bioDBnet.dbfind(values = ["DB00316","DB00945"],
            output = "KeggDrug", taxonid = "9606", rettype = "xml")
        @test res.status == 200
        @test startswith(Dict(res.headers)["Content-Type"], "application/xml")
        body = XMLDict.parse_xml(String(res.body))
        @test isa(body, XMLDict.XMLDictElement)
        @test first(body)[1] != "ERROR"
    end
end
